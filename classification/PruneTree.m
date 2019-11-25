function pruney = PruneTree(this_node)
    pruney = this_node;
    if(this_node.isLeafNode == 1)
        fprintf("this_node: %d is a leaf this_node", this_node.nodeID);
        pruney = this_node;
    elseif(this_node.kids{1}.isLeafNode == 1 && this_node.kids{2}.isLeafNode == 1)
            if (this_node.counterLeft>this_node.counterRight)
                this_node.class= this_node.kids{1}.class;
                this_node.kids = node.empty(2,0);
                this_node.isLeafNode = 1;
                pruney = this_node;
            else
                this_node.class=this_node.kids{2}.class;
                this_node.kids = this_node.empty(2,0);
                this_node.isLeafNode = 1;
                pruney = this_node;
            end
            
    else
        pruney.kids{1} = PruneTree(this_node.kids{1});
        pruney.kids{2} = PruneTree(this_node.kids{2});
    end
    
end
        
    