Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135FE28C869;
	Wed, 14 May 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249607; cv=none; b=LAomPqBUdUE/gQVor2NUdmR8ud2S+9+iLSekz3tChffG4BVjHMEs8wfVPkvrKz1kgbZsuLbYQ49EmuPIh7LzkfBgvsQDVY45p76PK9SsnWcdUK1hFixj26I26Pkc/9yFjnrROfpog349TgE2w0HLdWPkI3cpQT+FlFYIqbFenQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249607; c=relaxed/simple;
	bh=LEdQl75K9OR36Kd0VEkSwPOYpiFeh4aOsWkM6PJ25o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EI6D/UgaMAWEgcF6REu+/t/aTO/xroihiWobNylhV23bPFiwJrf5sVSWUygcCz7KnF8kMJprvn7m/kMsWqG13Nm+7dsFDoAw9oNqTEoTgcXt0TTo9NRALASDOQ0ZUt1zV6pzx3o1R9F/hXDBCWaG5XfCkyQjOj+H5Zkn3UaXNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEd7OFyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEd7OFyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE73C4CEE3;
	Wed, 14 May 2025 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747249606;
	bh=LEdQl75K9OR36Kd0VEkSwPOYpiFeh4aOsWkM6PJ25o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEd7OFyPfNHwAx6DSpRXBm2lIbznBmyU+5hiCuDCaaTh9fch36HI9DOqJlz2t28di
	 cLuNTgfNPo80wXaFteuO06dr0a75uNUTbz9xpVOIACPGSSBgx/FVGHU3el4wjLveaR
	 sPC4KcJ6G38/puoMLTQOxH9r9tvQorhI/ffBhAS+Kd+AAtENjU1Ua/LBHZ/z9LyEQc
	 vgihp8kydxq+kY4NEBDldUNHfa5T0ebZ/CEtPurYrVLOmMzPhyxlNXrqt45n8fSWF/
	 6SKtVy6YpQPhKIcxH0gZyontF2oMQnOV+8Owjhd7MHyuccxyKNpd8mxBVkIvmEORYv
	 ilLPthv6RK1bg==
Date: Wed, 14 May 2025 12:06:44 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <rbghhbko7wervmjtejgambxt7eacn647m747gnfsvfwuwseqhz@5z7bqeycnfzv>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
 <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
 <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
 <jgdcnclxhw62rs2jb67n4wmmvnmc7l6mnnmlyhzkec3gb6zovp@rccwil2bi4bb>
 <ft6buh2oquxdygzxzobfmnjnatpuf6k6eetjtlqi2o3myv5qu3@vdt3t2yyprsv>
 <ecslihevvegiywtch4ckdw27x3h6mnekj7gf3lrbrtjwwzfodo@k5ks4ixf5i7j>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecslihevvegiywtch4ckdw27x3h6mnekj7gf3lrbrtjwwzfodo@k5ks4ixf5i7j>

On Tue, May 13, 2025 at 11:40:05PM -0400, Kent Overstreet wrote:
> On Tue, May 13, 2025 at 08:38:57PM -0700, Josh Poimboeuf wrote:
> > On Tue, May 13, 2025 at 08:44:49PM -0400, Kent Overstreet wrote:
> > > On Tue, May 13, 2025 at 05:37:11PM -0700, Josh Poimboeuf wrote:
> > > > On Tue, May 13, 2025 at 07:34:59PM -0400, Kent Overstreet wrote:
> > > > > On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> > > > > > > +++ b/include/linux/moduleparam.h
> > > > > > > @@ -122,6 +122,7 @@ struct kparam_array
> > > > > > >   *	charp: a character pointer
> > > > > > >   *	bool: a bool, values 0/1, y/n, Y/N.
> > > > > > >   *	invbool: the above, only sense-reversed (N = true).
> > > > > > > + *	static_key_t: same as bool, but updates a 'struct static_key'
> > > > > > 
> > > > > > The static_key_*() interfaces are deprecated because they're really easy
> > > > > > to use incorrectly.  I don't think we want to propagate that misuse to
> > > > > > modules.
> > > > > > 
> > > > > > It would be better to have type(s) based on static_key_false and/or
> > > > > > static_key_true, depending on whatever the default is.
> > > > > 
> > > > > Except those are just wrappers around struct static_key, so why does
> > > > > that matter here?
> > > > 
> > > > Those struct wrappers are needed to work with static_branch_likely() and
> > > > static_branch_unlikely().
> > > 
> > > Sure, but this has no bearing on that - unless I've missed them, there
> > > aren't separate methods for just setting and checking the value, which
> > > is all we're doing here.
> > 
> > To make use of this feature, wouldn't the module need to use
> > static_key_false() or so to actually insert the static branch to check
> > the value?  Otherwise what's the point of using static keys here?
> 
> I'm not sure I follow?
> 
> You just pass the inner static_key to the modparam, you still use
> static_key_true or static_key_false as normal.

Ok, so the caller does something like so?

  DEFINE_STATIC_KEY_FALSE(foo);
  module_param_named(foo, foo.key, static_key_t, 0);

I guess that works, but 'foo.key' is awkward in that it's nonobvious and
breaks the abstraction.  Driver people might end up allocating
static_key directly and using the deprecated interfaces again.

My preference would be to stick to the supported interfaces, e.g.:

  DEFINE_STATIC_KEY_FALSE(foo);
  module_param_named(foo, foo, static_key_false_t, 0);

-- 
Josh
