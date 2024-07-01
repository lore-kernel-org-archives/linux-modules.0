Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38743BBED
	for <linux-modules@vger.kernel.org>; Mon,  1 Jul 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833980; cv=none; b=W+fQDAGmMVEMADn9LDAz8vD8bsztRivAc/a7yrKjtirPZUts4QObWM6RLhcOgsdaBL1NY463aXv2M+nUWxKRo2DTFxYSrD7bavVwx2ct59QuxnTgXCbhJOdxxoujKd+Pf9FeKMtYRyECg468nQKgsaCsRGQFIeWYoP4h9SYEsoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833980; c=relaxed/simple;
	bh=KjOhJlp0NRDwVxS1+Q5ZN+qYH+76msgiF0E2lnCFIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6fTnUIhsvd236Ddl2vPIqjdxnp9P2m0DlZYVuLiqz0s2SqCOc0l1zxOW4KLh3d0Envjh+jeVB2rLQ0yTQwZOeTSKCoDN7wDogRRCNZofLdfEtofb4Wgd5mDeyseWSATlwfkt3qeaLVbt5qqP/HK9DZQbShaap5b97cYcFWarjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=gMjHq8Bg; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="gMjHq8Bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1719833633; bh=KjOhJlp0NRDwVxS1+Q5ZN+qYH+76msgiF0E2lnCFIbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMjHq8Bgpdw0GU+KETXksb+3elwK6YDPamml6ZLWVZPnYw5fe8LU3EC4f37ZcLWkk
	 RFGXR4F50zDdaVZsPOsDYHqs0VI3/CozFPgeuNqS5H/dYD1uhsm7HThHafNnJbK6mZ
	 QwKLE1DKYL/Nz8gjyoPMJPGd/DJ6b+AxglJx+KTE=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 13:33:53 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 95FCF806C4;
	Mon,  1 Jul 2024 13:33:53 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 85C4E181104; Mon,  1 Jul 2024 13:33:53 +0200 (CEST)
Date: Mon, 1 Jul 2024 13:33:53 +0200
From: Nicolas Schier <n.schier@avm.de>
To: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)" <vchernou@cisco.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [MODALTS v0.1 4/4] add modules deps alternatives description
Message-ID: <20240701-grinning-sapphire-labrador-eaa91e@buildd>
References: <20240510112128.2417494-4-vchernou@cisco.com>
 <z6dffospgjlmczpc3ydj34t7rf37dq7f5vjjd4e6txpw2hmoex@6s26au6y4puj>
 <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7765763AE24FC792CB3F72BFDED32@DS0PR11MB7765.namprd11.prod.outlook.com>
X-purgate-ID: 149429::1719833633-D4E1B1E5-AAABA66F/0/0
X-purgate-type: clean
X-purgate-size: 5929
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Mon, Jul 01, 2024 at 09:23:03AM +0000, Valerii Chernous wrote:
> >On Fri, May 10, 2024 at 04:21:28AM GMT, Valerii Chernous wrote:
> >>Cc: xe-linux-external@cisco.com
> >>Cc: Valerii Chernous <vchernou@cisco.com>
> >>Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> >>---
> >> README.deps.alternatives.txt | 40 ++++++++++++++++++++++++++++++++++++
> >> 1 file changed, 40 insertions(+)
> >> create mode 100644 README.deps.alternatives.txt
> >>
> >>diff --git a/README.deps.alternatives.txt b/README.deps.alternatives.txt
> >>new file mode 100644
> >>index 0000000..9ad3ce5
> >>--- /dev/null
> >>+++ b/README.deps.alternatives.txt
> >>@@ -0,0 +1,40 @@
> >>+Modules alternatives feature allow to calculate dependency alternatives
> >>+during build time and aviod to regenerate modules db into runtime
> >>+
> >>+To enable deps alternatives calculation use "-D" flag with depmod,
> >>+it will create indexes modules.alternatives and modules.alternatives.bin
> >>+This indexes will be used by modprobe in runtime
> >>+By default modprobe will load first(primary/major) dependency from list
> >>+If it required to load alternative module, it should be done manually before
> >>+loading main modules set.
> >>+For example systemd service that detect platform type can load required platform
> >>+modules and after it run main device initialization
> >>+In case when alternative module loaded, modprobe detect this and skip to load primary
> >>+dependency
> >>+
> >>+modules deps alternatives generation basic algorithm description
> >>+1. Load modules information(imported/exported symbols)
> >>+2. Find depended symbol alternatives(create list available symbols
> >>+   alternatives instead of storing last one)
> >>+3. Choise primary/major alternative per depended symbol correspond to
> >>+   build time dependency(build time deps getting from module info section)
> >>+4. Create a list of dependency modules alternatives correspond to next rule:
> >>+4.1 All modules alternatives for module dependency should provide all symbols
> >>+5 Store modules alternatives index(modules.alternatives) as key:value where
> >>+key is a pair depended#_#primary_depency,
> >>+value is list of all modules that provide all symbols from primary_depency
> >>+for depended module
> >>+
> >>+Note:
> >>+Current implementation/algorithm doesn't cover variant where requred symbols
> >>+from primary deps provided by more that one modules. Exporting all symbols in
> >>+alternative depency that used by depended module from primary_depency is
> >>+mandatory!
> >>+
> >>+Note:
> >>+modules.dep index different for standard/basic and modules alternatives algorithms
> >>+modules.dep for modules alternatives algorithm contain only direct dependencies and
> >>+full dependency list will be calculated into runtime correspond to preferred alternative.
> >>+modules.dep for standard/basic algorithm contain full dependency list for module and
> >>+can't be changed during runtime without rebuild database via depmod
> 
> 
> >well... this kind of explains the what, but still no clue on why.
> >If multiple different modules are providing the same symbol, then they
> >are doing things wrong.
> 
> >If there are multiple variants of the same module (again, is this about
> >external modules?), then I see no advantage to delay the decisions from
> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
> 
> >Also end users have not visibility on a README.deps.alternatives.txt
> >file. Documentation in kmod is kept on man pages.
> 
> 
> >Lucas De Marchi
> 
> First at all, thank you for review, Lucas.
> Let me try to explain feature more:
> 1. You are correct, feature tested on external modules
> 
> 2.
> >If multiple different modules are providing the same symbol, then they
> >are doing things wrong.
> 
> Modules exported the same api(the same functions) and on my opinion it's ok
> and kernel process normally different modules with the same exports. One major
> restriction is only one module with the same symbols can be loaded on the same
> time but it's ok in my case(as I described, in my case, it's per platform
> modules and devices with different hardware using the same software image).
> 
> 3.
> >If there are multiple variants of the same module (again, is this about
> >external modules?), then I see no advantage to delay the decisions from
> >depmod-time to modprobe-time. Just setup your depmod.d configuration.
> 
> It can be different variant of the same module but maybe not. For example it
> can be cryptography modules. Modules provide the same api but implementation
> of api is totally different and depend on specific hardware. With modules
> alternatives feature it's easy to use this kind of modules. You can use
> required alternative for specific hardware and all depended modules can use
> external functions directly without any wrappers or "if" statements to resolve
> dependencies.
> With using depmod.d configuration it's possible to choose primary alternative
> into build time but in my case required alternative is unknown during build time,
> it will be known only into runtime. In this case it required to regenerate
> modules db into runtime and I try to avoid this.

It sounds to me, as if you would like to auto-generate modprobe.d/ files
for your platforms at boot time and implement the pre-loading of some
modules before some others with common modprobe.d syntax (e.g.
'install', cp. modprobe.d(5)).  But you probably evaluated that before
implementing your patches?

If your module load order is just platform dependent, I do not yet
understand, why (possibly boot-time dynamic) depmod.d configuration is
not sufficiently flexible enough.  I probably have missing some
important point.

I strongly support Lucas' request for a cover-letter.

Kind regards,
Nicolas
