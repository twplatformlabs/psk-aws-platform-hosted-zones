<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png?sanitize=true" width=350/>
	</p>
  <h3>lab-platform-hosted-zones</h3>
</div>
<br />

Create cluster subdomain hosted zones and zone delegations.  

### single declarative state

This pipeline assumes that a top-level hosted zone already exists in one of the platform products teams aws accounts (either purchased through aws or with top-level delegation).  

This is a single declarative state configuration maintenance pipeline. Multiple aws account providers are configured in the same plan to reconcile the dependent state between aws accounts and delegation zones.  



dns-manager role not yet defined with prod account assumability
