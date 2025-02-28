<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/twplatformlabs/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/twplatformlabs/static/master/EMPCPlatformStarterKitsImage.png?sanitize=true" width=350/>
		<br />
	</p>
  <h3>psk-aws-platform-hosted-zones</h3>
	<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/twplatformlabs/psk-aws-platform-hosted-zones"></a> <a href="https://aws.amazon.com"><img src="https://img.shields.io/badge/-deployed-blank.svg?style=social&logo=amazon"></a>
</div>
<br />

Multi-account subdomain hosted zones and zone delegations.  

_note. in these charts, *.domain indicates the hosted zone delegation will manage every subdomain no specifically delegated._  

## psk aws managed domains in aws-production
| domain                 |
|------------------------|
| *.twplatformlabs.org   |
| *.twplatformlabs.link  |

**Creates the following, cluster-specific hosted zones in the specified account:**  
| hosted zone                                      | aws-sandbox | aws-production |
|--------------------------------------------------|:-----------:|:--------------:|
| *.sandbox-i01-aws-us-east-1.twplatformlabs.org   |      •      |                |
| *.sandbox-i01-aws-us-east-1.twplatformlabs.link  |      •      |                |
| *.prod-i01-aws-us-east-2.twplatformlabs.org      |             |         •      |
| *.prod-i01-aws-us-east-2.twplatformlabs.link     |             |         •      |

**Creates the following environment specific zones:**
| gateway                                 | aws-sandbox | aws-production |
|-----------------------------------------|:-----------:|:--------------:|
| *.preview.twplatformlabs.org-gateway    |      •      |                |
| *.preview.twplatformlabs.link-gateway   |      •      |                |
| *.dev.twplatformlabs.org-gateway        |             |         •      |
| *.dev.twplatformlabs.link-gateway       |             |         •      |
| *.qa.twplatformlabs.org-gateway         |             |         •      |
| *.qa.twplatformlabs.link-gateway        |             |         •      |
| *.api.twplatformlabs.org-gateway        |             |         •      |
| *.api.twplatformlabs.link-gateway       |             |         •      |

By convention in the production environment, UI (SPA, static site, etc) resides on twplatformlabs.org (e.g., without the api subdomain) or *. (meaning, non-delegeted subdomains). Apart from that general UI convention, all traffic to individual deployed services is based on the right-of-domain path pattern.  

*General ingress patterns related to the top-level domains supported by the platform will be managed through a dedicated platform API. See the (psk-platform-simple-teams-and-ns)[https://github.com/twplatformlabs/psk-platform-simple-teams-and-ns] for a simple strategy for managing ingress while the dedicated management API is in development.  

Keep in mind that it is not uncommon to adopt a relatively static pattern for domain ingress where internal developers have a limited set of choices because of the product decisions made. Where that is true, and therefor no custom API experiences is needed, it is a effective strategy to simply include that DNS management here as a simple all-in-one location.  

### single declarative state

This is a single declarative state configuration maintenance pipeline. Multiple aws account providers are configured in the same plan to reconcile the dependent state between aws accounts and delegation zones. The top level domains are assumed to already exist.  

Note: this pattern is used for platform-managed domains that provide customers automated _right_-of-domain ingress.  

**Deprecated**  
These are the prior ThoughtWorks-DPS domains andn will be removed soon.  
## psk aws managed domains
| domain           | top-level domain account |
|------------------|:------------------------:|
| *.twdps.io       | aws-dps-1                |  
| *.twdps.digital  | aws-dps-2                |

**Creates the following, cluster-specific hosted zones in the specified account:**  
| hosted zone                                | aws-dps-1 | aws-dps-2 |
|--------------------------------------------|:---------:|:---------:|
| *.sandbox-i01-aws-us-east-1.twdps.digital  |           |     •     |
| *.sandbox-i01-aws-us-east-1.twdps.io       |           |     •     |
| *.prod-i01-aws-us-east-2.twdps.digital     |     •     |           |
| *.prod-i01-aws-us-east-2.twdps.io          |     •     |           |

**Creates the following environment specific zones:**
| gateway                                   | aws-dps-1 | aws-dps-2 |
|-------------------------------------------|:---------:|:---------:|
| *.preview.twdps.digital-gateway           |           |     •     |
| *.preview.twdps.io-gateway                |           |     •     |
| *.dev.twdps.digital-gateway               |     •     |           |
| *.dev.twdps.io-gateway                    |     •     |           |
| *.qa.twdps.digital-gateway                |     •     |           |
| *.qa.twdps.io-gateway                     |     •     |           |
| *.api.twdps.digital-gateway               |     •     |           |
| *.api.twdps.io-gateway                    |     •     |           |
