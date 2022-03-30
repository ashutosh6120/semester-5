import java.util.Scanner;
class node {
	public node(long dist, long parent) {
		this.dist = dist;
		this.parent = parent;
	}
	public long dist;
	public long parent;
}

public class BellmanFord {
	public static void main(String[] args) {
		long n;
		long[][] dist;
		node[][] routing_tables;
		Scanner s = new Scanner(System.in);
		System.out.print("enter no of nodes in network: ");
		n = s.nextLong();
		dist = new long[(int)n][(int)n];
		routing_tables = new node[(int)n][(int)n];
		System.out.println("enter the distance matrix(-1 for infinity): ");
		for(int i=0;i<n;i++) {
			for(int j=0;j<n;j++) {
				routing_tables[i][j] = new node(Integer.MAX_VALUE,-1);
				dist[i][j] = s.nextLong();
				if(dist[i][j]==-1)
					dist[i][j]=Integer.MAX_VALUE;
			}
		}
		
		for(int i=0;i<n;i++) {
			routing_tables[i][i].dist=0;
			routing_tables[i][i].parent=i;
		}
		
		for (int k = 0; k < n; k++) {
			for (int u = 0; u < n; u++) {
				for (int v = 0; v < n; v++) {
					for (int i = 0; i < n; i++) {
						if (dist[v][u] != Integer.MAX_VALUE && 
								routing_tables[i][v].dist != Integer.MAX_VALUE &&
								routing_tables[i][u].dist > routing_tables[i][v].dist + dist[v][u]) {
							routing_tables[i][u].dist = routing_tables[i][v].dist + dist[v][u];
							routing_tables[i][u].parent = v;
						}
					}
				}
			}
		}

		for (int i = 0; i < n; i++) {
			System.out.println("Routing table of for router " + (i + 1));
			System.out.println("Dest\tDist\tParent");
			System.out.println("----\t----\t------");
			for (int j = 0; j < n; j++) {
				System.out.println((j+1) + "\t" + routing_tables[i][j].dist + "\t" + (routing_tables[i][j].parent + 1));
			}
			System.out.println("\n");
		}
	
		s.close();		
	}
}