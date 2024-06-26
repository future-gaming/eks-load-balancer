package test

import (
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/eks"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEksCluster(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "..",
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	sess := session.Must(session.NewSession(&aws.Config{
		Region: aws.String("us-east-1"), 

	eksSvc := eks.New(sess)

	clusterName := terraform.Output(t, terraformOptions, "cluster_name")
	clusterInfo, err := eksSvc.DescribeCluster(&eks.DescribeClusterInput{
		Name: &clusterName,
	})
	if err != nil {
		t.Fatal("Failed to describe EKS cluster: ", err)
	}

	actualClusterVersion := *clusterInfo.Cluster.Version

	expectedClusterVersion := "1.30"
	assert.Equal(t, expectedClusterVersion, actualClusterVersion)
}
