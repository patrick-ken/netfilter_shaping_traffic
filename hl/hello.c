#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/netfilter.h>
#include <linux/netfilter_ipv4.h>
#include <linux/skbuff.h>
#include <linux/tcp.h>
#include <linux/ip.h>
#include <net/tcp.h>
#include <linux/hashtable.h>
//#include <linux/jhash.h>

static struct nf_hook_ops nfho;   //net filter hook option struct
struct sk_buff *sock_buff;
struct tcphdr *tcp_header;          //udp header struct (not used)
struct iphdr *ip_header;            //ip header struct

typedef struct{		
	uint16_t dest_port;
	uint16_t source_port;
	unsigned int dest_ip;
	unsigned int source_ip;
	unsigned int mss;
	//int speed;
	int window;
	unsigned int wnd_scale : 24;
	struct hlist_node my_list;
} connection;


unsigned int window_managment(void){
	unsigned int window = 0;
	int rtt = 0;
	int mss = 0;
	unsigned int BE = (mss) / rtt;
	unsigned int BA;
	float N = BE / BA;
	unsigned int current_window = 0;

	window = current_window / N;
	return window;
}

static struct nf_hook_ops nfho;         //struct holding set of hook function options

//function to be called by hook
unsigned int hook_func(unsigned int hooknum, struct sk_buff **skb, const struct net_device *in, const struct net_device *out, int (*okfn)(struct sk_buff *))
{
  printk(KERN_INFO "packet dropped\n");                                             //log to var/log/messages
  return NF_DROP;                                                                   //drops the packet
}

//Called when module loaded using 'insmod'
int init_module()
{
  nfho.hook = hook_func;                       //function to call when conditions below met
  nfho.hooknum = NF_INET_PRE_ROUTING;            //called right after packet recieved, first hook in Netfilter
  nfho.pf = PF_INET;                           //IPV4 packets
  nfho.priority = NF_IP_PRI_FIRST;             //set to highest priority over all other hook functions
  nf_register_hook(&nfho);                     //register hook

  return 0;                                    //return 0 for success
}

//Called when module unloaded using 'rmmod'
void cleanup_module()
{
  nf_unregister_hook(&nfho);                     //cleanup – unregister hook
}
