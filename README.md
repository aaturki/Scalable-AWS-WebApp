```mermaid
graph TD
    subgraph AWS Cloud
        subgraph VPC [VPC: 10.0.0.0/16]
            subgraph AZ1 [Availability Zone 1]
                subgraph PublicSubnet1 [Public Subnet]
                    ALB(Application Load Balancer)
                end
                subgraph PrivateSubnet1 [Private Subnet]
                    EC2_1(EC2 Instance 1)
                    RDS_P(RDS Primary)
                end
            end

            subgraph AZ2 [Availability Zone 2]
                subgraph PublicSubnet2 [Public Subnet]
                    ALB_Replica[...]
                end
                subgraph PrivateSubnet2 [Private Subnet]
                    EC2_2(EC2 Instance 2)
                    RDS_S(RDS Standby)
                end
            end

            %% Define the Auto Scaling Group across the private subnets
            subgraph ASG [Auto Scaling Group]
                EC2_1
                EC2_2
            end
        end
    end

    %% Define connections
    User(End User) --> Route53(Amazon Route 53)
    Route53 --> ALB
    ALB --> EC2_1
    ALB --> EC2_2
    EC2_1 --> RDS_P
    EC2_2 --> RDS_P
    RDS_P <-->|Multi-AZ Replication| RDS_S
    CloudWatch(Amazon CloudWatch) -- Monitors & Triggers --> ASG

    %% Style definitions
    style User fill:#527FFF,stroke:#333,stroke-width:2px
    style VPC fill:#232F3E,stroke:#fff,stroke-width:2px,color:#fff
    style AZ1 fill:#3E4B5B,stroke:#fff,stroke-width:1px,color:#fff
    style AZ2 fill:#3E4B5B,stroke:#fff,stroke-width:1px,color:#fff
    style ALB fill:#FF9900,color:#fff
    style ALB_Replica fill:#FF9900,color:#fff
    style EC2_1 fill:#FF9900,color:#fff
    style EC2_2 fill:#FF9900,color:#fff
    style RDS_P fill:#5A30B5,color:#fff
    style RDS_S fill:#5A30B5,color:#fff
    style Route53 fill:#7D4199,color:#fff
    style CloudWatch fill:#7D4199,color:#fff
