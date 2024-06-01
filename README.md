<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/EMPCPlatformStarterKitsImage.png?sanitize=true" width=350/>
		<br />
	</p>
  <h3>psk-aws-platform-hosted-zones</h3>
	<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/ThoughtWorks-DPS/psk-aws-platform-hosted-zones"></a> <a href="https://aws.amazon.com"><img src="https://img.shields.io/badge/-deployed-blank.svg?style=social&logo=amazon"></a>
</div>
<br />

Multi-account subdomain hosted zones and zone delegations.  

## psk aws managed domains
| domain         | top-level domain account |
|----------------|:------------------------:|
| twdps.io       | aws-dps-1                |  
| twdps.digital  | aws-dps-2                |

**Creates the following hosted zones in the specified account:**  
| hosted zone                              | aws-dps-1 | aws-dps-2 |
|------------------------------------------|:---------:|:---------:|
| sandbox-i01-aws-us-east-1.twdps.digital  |           |     •     |
| sandbox-i01-aws-us-east-1.twdps.io       |           |     •     |
| preview.twdps.digital                    |           |     •     |
| preview.twdps.io                         |           |     •     |
| prod-i01-aws-us-east-2.twdps.digital     |     •     |           |
| prod-i01-aws-us-east-2.twdps.io          |     •     |           |
| dev.twdps.digital                        |     •     |           |
| dev.twdps.io                             |     •     |           |
| qa.twdps.digital                         |     •     |           |
| qa.twdps.io                              |     •     |           |
| prod.twdps.digital                       |     •     |           |
| prod.twdps.io                            |     •     |           |

### single declarative state

This is a single declarative state configuration maintenance pipeline. Multiple aws account providers are configured in the same plan to reconcile the dependent state between aws accounts and delegation zones. The top level domains are assumed to already exist.  

Note: this pattern is used for platform-managed domains that provide customers automated _right_-of-domain ingress.  
