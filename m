Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E01D79A5;
	Wed, 14 May 2025 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193940; cv=none; b=BFiUghBGqSnhPflH8ApgunRaGJDDYrxP6AHpSblgNUr8VYnV5TgOACrrZWqD2zI63zGbvA2C7JWaeuhCstG02bIZJIRZ3DdbJ6QV0xCQDLPg/tgKqK8XdyE7Kl6NNC/wRD2h4iq66Q12NtvZ/F5JeRXjQGvIypKnBn9XTeN2V7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193940; c=relaxed/simple;
	bh=nkIIBBijf1JlW2gYe6G5ZP+HpfQx9QDsr5Jb8eacet8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKkxX4X1XiJx604sPiqlOgiycaR51lcUZ5vShX41zjJK5mcfzy+WGgG2nzcd7cjNaCkXGy/J5hlRtUYhyLVl28DF1Wm8PlKhCIyCpeDjdG2mTz8xml4vezff9phbYgijpmgXK0mvPFDLdR2/h+BU0DvyLh03im3oh8Iga5BT91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIZ3nudN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIZ3nudN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A5C4CEED;
	Wed, 14 May 2025 03:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747193939;
	bh=nkIIBBijf1JlW2gYe6G5ZP+HpfQx9QDsr5Jb8eacet8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIZ3nudNBjHzqihItNhUSQQ3K0gJgjUMYYDf5YWmNZ31hNQmAOn2nyXxsi0JjeBbs
	 nzwwlTDmsuZD2gRiNBkzVheeIsBonHv1xR253vK6wLLWbDu6uDxYzBbOouv2rV6grH
	 lJdcHJ5VTGfUj7RWHqEjf5xk6rjQcvUK1KvK4qeYFMX8JlDzjKaESMJVL8r5vCPAm1
	 agIZBrAujvOOKFucL/VAbTd11qqDm2b/FYTqIFwaaIAoChj+y9gCmLWtEYNIfKXXhv
	 b/GReFTRuEjSed7gD40r98Ag/+o8aoioziEdD4RoYCWa7dNJ4gX84u+VD7aHDVesgC
	 GsAz9kwmp/7+A==
Date: Tue, 13 May 2025 20:38:57 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <ft6buh2oquxdygzxzobfmnjnatpuf6k6eetjtlqi2o3myv5qu3@vdt3t2yyprsv>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
 <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
 <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
 <jgdcnclxhw62rs2jb67n4wmmvnmc7l6mnnmlyhzkec3gb6zovp@rccwil2bi4bb>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jgdcnclxhw62rs2jb67n4wmmvnmc7l6mnnmlyhzkec3gb6zovp@rccwil2bi4bb>

On Tue, May 13, 2025 at 08:44:49PM -0400, Kent Overstreet wrote:
> On Tue, May 13, 2025 at 05:37:11PM -0700, Josh Poimboeuf wrote:
> > On Tue, May 13, 2025 at 07:34:59PM -0400, Kent Overstreet wrote:
> > > On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> > > > > +++ b/include/linux/moduleparam.h
> > > > > @@ -122,6 +122,7 @@ struct kparam_array
> > > > >   *	charp: a character pointer
> > > > >   *	bool: a bool, values 0/1, y/n, Y/N.
> > > > >   *	invbool: the above, only sense-reversed (N = true).
> > > > > + *	static_key_t: same as bool, but updates a 'struct static_key'
> > > > 
> > > > The static_key_*() interfaces are deprecated because they're really easy
> > > > to use incorrectly.  I don't think we want to propagate that misuse to
> > > > modules.
> > > > 
> > > > It would be better to have type(s) based on static_key_false and/or
> > > > static_key_true, depending on whatever the default is.
> > > 
> > > Except those are just wrappers around struct static_key, so why does
> > > that matter here?
> > 
> > Those struct wrappers are needed to work with static_branch_likely() and
> > static_branch_unlikely().
> 
> Sure, but this has no bearing on that - unless I've missed them, there
> aren't separate methods for just setting and checking the value, which
> is all we're doing here.

To make use of this feature, wouldn't the module need to use
static_key_false() or so to actually insert the static branch to check
the value?  Otherwise what's the point of using static keys here?

-- 
Josh
