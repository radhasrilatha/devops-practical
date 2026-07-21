module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.37"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
    }
    eks-pod-identity-agent = { # Add this first
      most_recent = true
    }    # Added EBS CSI Driver
    aws-ebs-csi-driver = {
      most_recent              = true
      attach_volume_iam_policy = true # Automatically attaches required IAM policy to the addon role
    }
  }

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]

      min_size     = 2
      desired_size = 2
      max_size     = 3

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project = "swimlane"
  }
}
