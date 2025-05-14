Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A71D79A5
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747194024; cv=none; b=pEMl7LEhbv7yG5oSyH5XQDQRgeGEeFHR7bzeGWJRDI0g13B0Qxe/54YYdySWJPHRen+OBNcm5WeNYIHGKYn87A7dHU2aJEnmJvJvD0irKOdqlFISeu43Uw1fMnUPz21xlr2r/kENnJha2N3JwKLglBwVQfjElYl8w+/ww45dssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747194024; c=relaxed/simple;
	bh=I3R+rQ27w0UGwmfv882mYWoYHzH7py1R9rJyM6PQRvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epeLdz3wtyGNXwHfmRPzg4nNZfO/5T1D67szHjhJ7G7xqTKXXs+eb3yhqLPq08eR6PzMDCH/UUTrPF5JIgvRkOY1DcUPt/gEvCYwz1JxVNCVe8O5Brzz25trCZBT/1hKAtOoMCM3dyzUIVpcEyzIgVK4WbKcx0PUC/T1e5PbQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnBedwyx; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnBedwyx"
Date: Tue, 13 May 2025 23:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747194009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NA7E2kJOA5MHkkOq+Sx2r/MfVDTe3tDwcatQiM1q45w=;
	b=EnBedwyx6gTTOnGeSctw7qq5IFCGnAFUceh5SCoKottoFx/PB9ZOAvlsaI4k9D7birp4K3
	vmcl6MeeIwpgJfcJqcQ1tDIJ2QewUD71dBlwFyRTO3C4D8VqQF8HaE3JywPd2JKuAD8GOL
	SFUkpzSR9cCQ0Vdlg/NegdypV8aX3Fo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <ecslihevvegiywtch4ckdw27x3h6mnekj7gf3lrbrtjwwzfodo@k5ks4ixf5i7j>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
 <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
 <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
 <jgdcnclxhw62rs2jb67n4wmmvnmc7l6mnnmlyhzkec3gb6zovp@rccwil2bi4bb>
 <ft6buh2oquxdygzxzobfmnjnatpuf6k6eetjtlqi2o3myv5qu3@vdt3t2yyprsv>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ft6buh2oquxdygzxzobfmnjnatpuf6k6eetjtlqi2o3myv5qu3@vdt3t2yyprsv>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 08:38:57PM -0700, Josh Poimboeuf wrote:
> On Tue, May 13, 2025 at 08:44:49PM -0400, Kent Overstreet wrote:
> > On Tue, May 13, 2025 at 05:37:11PM -0700, Josh Poimboeuf wrote:
> > > On Tue, May 13, 2025 at 07:34:59PM -0400, Kent Overstreet wrote:
> > > > On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> > > > > > +++ b/include/linux/moduleparam.h
> > > > > > @@ -122,6 +122,7 @@ struct kparam_array
> > > > > >   *	charp: a character pointer
> > > > > >   *	bool: a bool, values 0/1, y/n, Y/N.
> > > > > >   *	invbool: the above, only sense-reversed (N = true).
> > > > > > + *	static_key_t: same as bool, but updates a 'struct static_key'
> > > > > 
> > > > > The static_key_*() interfaces are deprecated because they're really easy
> > > > > to use incorrectly.  I don't think we want to propagate that misuse to
> > > > > modules.
> > > > > 
> > > > > It would be better to have type(s) based on static_key_false and/or
> > > > > static_key_true, depending on whatever the default is.
> > > > 
> > > > Except those are just wrappers around struct static_key, so why does
> > > > that matter here?
> > > 
> > > Those struct wrappers are needed to work with static_branch_likely() and
> > > static_branch_unlikely().
> > 
> > Sure, but this has no bearing on that - unless I've missed them, there
> > aren't separate methods for just setting and checking the value, which
> > is all we're doing here.
> 
> To make use of this feature, wouldn't the module need to use
> static_key_false() or so to actually insert the static branch to check
> the value?  Otherwise what's the point of using static keys here?

I'm not sure I follow?

You just pass the inner static_key to the modparam, you still use
static_key_true or static_key_false as normal.
