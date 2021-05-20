<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-documentation/blob/master/doc/img/dps-lab.png?sanitize=true" width="75" />
	</p>
  <h3>ThoughtWorks DPS Lab</h3>
  <h5>lab-platform-hosted-zones</h5>
</div>
<br />

Create cluster subdomain hosted zones and zone delegations.  

### single declarative state

This pipeline assumes that a top-level hosted zone already exists in one of the platform products teams aws accounts (either purchased through aws or with top-level delegation).  

This is a single declarative state configuration maintenance pipeline. Multiple aws account providers are configured in the same plan to reconcile the dependent state between aws accounts and delegation zones.  
