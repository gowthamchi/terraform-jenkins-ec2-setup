import jenkins.model.*
import hudson.security.*
import org.jenkinsci.plugins.workflow.job.*
import org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition
import hudson.plugins.git.*
import com.cloudbees.jenkins.GitHubPushTrigger

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount("admin", "admin")
Jenkins.instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
Jenkins.instance.setAuthorizationStrategy(strategy)

def jobName = "nodejs-deploy-job"
if (Jenkins.instance.getItem(jobName) == null) {
    def job = Jenkins.instance.createProject(WorkflowJob, jobName)

    def scm = new GitSCM(
        [new UserRemoteConfig("https://github.com/gowthamchi/terraform-jenkins-ec2-setup.git", null, null, null)],
        [new BranchSpec("*/main")],
        false, [], null, null, []
    )

    def flowDef = new CpsScmFlowDefinition(scm, "jenkins/jenkinsfile")
    flowDef.setLightweight(true)
    job.setDefinition(flowDef)

    job.addTrigger(new GitHubPushTrigger())
    job.save()
}
