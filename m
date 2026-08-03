Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6939185C
	for <linux-modules@vger.kernel.org>; Mon,  3 Aug 2026 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735443; cv=none; b=iTmQMew0yAdOtZ3nIgJy66JMObd9mlYLhdVmkHLvmL7t594avOTOSEGD/XSubUYR0FxV18xHYaswhgdxl3gV8/eMHnrEBRhy0+X/4hLp3HA0/rbkckYLe9NcfnySQd61V/bq+ZNklrRgIXJQIQ2GgczCKT1gfeQlvDuHjgPjaa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735443; c=relaxed/simple;
	bh=dWrl7y9k96yWZtvZnvsbaLtlTDmNFmOcZe5IkqxOVbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj8ocySutimUBQ+Z3ACmubwRT36UoLdVGwbw9QLXDHASlCu8T+mUAvqHtSkbCHoAll4SBA43HPdjGqIAZQZMb4lBpc8pIcVJWKvzSLt54dLjxhdr1Dzq9dis9aZ3eHK20GzXPv246llOvf1FaqY4fZWrT61oBxV1iZwFC6c9dZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVBrLFw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVBrLFw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD7C1F000E9;
	Mon,  3 Aug 2026 05:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785735442;
	bh=3VI2kKdgmmGt1E+XNE38qwre03y6m/4kLExE4gCmMDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gVBrLFw/EEwuWA2Z2Q9b74Yrg3bzS6N3PSZ4+9sobTBWH/OFQ7oC18t0g2J+UMMne
	 KIWXSWwYSFqQvh6w779K4RBoAsSt96d5uEWIqTMhMC8af4rBYjXaZdwO8JLTYXEpio
	 w2ip4SHRikyzTCopCUSY8dwUWBzYKq4naTMoEJeTFEjkEufRBRusPqMMkOOU5tRJFp
	 dNYWqvm58HOFN3csoj3k6dVVOKdejQs79n59bVFJvvGk3ofykZ8wxrcGzI6wfvDgB+
	 S5YAv7pRMPBLurUzHzZa09AF7SbU/G2jhMN0A0VZH4LUWU+GBKmDGd+Ct8dfZXaCG/
	 2ZM9jMp+7dN2A==
Date: Sun, 2 Aug 2026 22:37:20 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-modules@vger.kernel.org
Subject: Re: [PATCH 02/14] objtool/klp: Normalize Module.symvers paths to
 module names
Message-ID: <zzkvlumnxwpxztjdqiuepabji6nktihnjhy65oofth4fvipn6y@c73eecgpav7f>
References: <cover.1785727106.git.jpoimboe@kernel.org>
 <dbe1b72931bd3c31b751fd0729613d9f2226fff6.1785727106.git.jpoimboe@kernel.org>
 <20260803033711.7C6EB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803033711.7C6EB1F000E9@smtp.kernel.org>

On Mon, Aug 03, 2026 at 03:37:11AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Medium]
> Does this assignment leak the original pointer returned by strdup()?
> 
> Looking at read_exports(), export->mod is allocated via strdup() right
> before this check:
> 
>         export->mod = strdup(mod);
>         if (!export->mod) {
>                 ERROR_GLIBC("strdup");
>                 return -1;
>         }
> 
>         if (strcmp(export->mod, "vmlinux"))
>                 export->mod = normalize_modname(export->mod);
> 
> When processing module paths with a slash, normalize_modname() returns
> an interior pointer (slash + 1).
> 
> If this offset pointer overwrites export->mod, the original base
> address from strdup() is permanently lost. 
> 
> While objtool often relies on process termination for cleanup, if these
> strings are ever freed later, passing an interior pointer to free() will
> cause an invalid free crash.
> 
> Could this be avoided by shifting the string contents in-place with
> memmove() instead?

Perhaps, but these are small memory leaks and klp diff frees all its
memory when it exits so I'm not sure we care.

-- 
Josh
