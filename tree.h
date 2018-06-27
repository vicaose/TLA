#define MAXNODES 4

static Node* newNode(char* value, char* type);
void addNode(Node* parent, Node* son);
void addTerminalNode(Node* parent, nodeType type);
char* getValue(Node * node);

typedef struct{
	char* nodeValue;         
	Node* * children;
	int child;   
 	char* nodeType;
}Node;
