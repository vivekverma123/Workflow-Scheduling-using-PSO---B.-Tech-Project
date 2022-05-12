#include <bits/stdc++.h>
using namespace std;

const int MIN_BANDWIDTH = 1;
const int MAX_BANDWIDTH = 10;
const int MIN_DEADLINE = 20;
const int MAX_DEADLINE = 100;
const int MIN_INSTRUCTIONS = 500;
const int MAX_INSTRUCTIONS = 1000;
const int MIN_CAPACITY = 10;
const int MAX_CAPACITY = 100;


int rangerand(int left, int right) {
    return (rand() % (right - left + 1) + left);
}

int main() {
    int num_vertices, num_edges;

    cin >> num_vertices >> num_edges;

    vector<vector<int> > edges(num_edges, vector<int> (3));

    vector<int> indegree(num_vertices + 1, 0);
    vector<int> outdegree(num_vertices + 1, 0);


    for(int i = 0; i < num_edges; i++) {
        cin >> edges[i][0] >> edges[i][1] >> edges[i][2];

        indegree[edges[i][1]]++;
        outdegree[edges[i][0]]++;
    }

    for(int i = 1; i < num_vertices + 1; i++) {
        if(indegree[i] == 0) {
            edges.push_back({0, i, 0});
        }

        if(outdegree[i] == 0) {
            edges.push_back({i, num_vertices + 1, 0});
        }
    }

    int num_vms;
    cin >> num_vms;

    vector<vector<int> > energy_model(num_vertices + 2, vector<int> (num_vms, 0));

    for(int i = 1; i < num_vertices + 1; i++) {
        for(int j = 0; j < num_vms; j++) {
            cin >> energy_model[i][j];
        }
    }

    srand(time(0));

    int bandwidth = rangerand(MIN_BANDWIDTH, MAX_BANDWIDTH);
    int deadline = rangerand(MIN_DEADLINE, MAX_DEADLINE);

    vector<int> instructions(num_vertices + 2, 0);
    for(int i = 1; i < num_vertices + 1; i++) {
        instructions[i] = rangerand(MIN_INSTRUCTIONS, MAX_INSTRUCTIONS);
    }

    vector<int> compute_capacity(num_vms, 0);
    for(int i = 0; i < num_vms; i++) {
        compute_capacity[i] = rangerand(MIN_CAPACITY, MAX_CAPACITY);
    }

    cout << bandwidth << " " << num_vertices + 2 << " " << num_vms << " " << deadline << " " << edges.size() << endl;

    for(auto e: edges) cout << e[0] << " " << e[1] << " " << e[2] << endl;

    for(auto e: instructions) cout << e << " ";
    cout << endl;

    for(auto e: compute_capacity) cout << e << " ";
    cout << endl;

    for(int i = 0; i < num_vertices + 2; i++) {
        for(int j = 0; j < num_vms; j++) {
            cout << energy_model[i][j] << " ";
        }
        cout << endl;
    }

    return 0; 
}