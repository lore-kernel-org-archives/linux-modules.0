Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC44C7C
	for <linux-modules@vger.kernel.org>; Wed, 14 May 2025 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747183499; cv=none; b=XmUpm6Cx/eamdmAS+43g2lrwRxll/kffdubNxCunRZwdi1Ia7FaiiSgnYyU1QPbvP6IP/G2jqIrvPvhBLRKJcDVn9IK7+WUBpOiJNc2YS+LpZ6tqoPZ35Buz5CJIbycyB9f/8tTNWTbFGjNso8PYadUrmXiRByZCOXfzs5TrkV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747183499; c=relaxed/simple;
	bh=i+VUFNwWBt1Zt3XW0UIjXt4ZzP9tj/hKn9kj4HcXB40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnwwzjvkFpQYMQzvthhn1y4CgVtsSAAF47oLW9ZYUPH0CH0gV63UQGz/A2e4jwonIcHNpH/kexGdT2mhoZP7iF0/yvFOAR+uokbBnnGbPtNlTiwksdo8qobLheo1KuAcNF0tKLRIQ20pdQuPUsU33/4Im4TN0vDis4CRXbAUetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JPArT3yp; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JPArT3yp"
Date: Tue, 13 May 2025 20:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747183493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lThS1DBm31ojH1vq3yVCCo0L8L1BVoisB5S+pm8qiUg=;
	b=JPArT3yphW2mbTDfm4sFg0aMbpSnhCu4ykNEGcW7sHiUGWn2tHK6yEWQ0B4yKSbAtF04Bs
	pyHNRt51bwaEj+AMKUc5yR6012hKqg1XwWU0IkY9hnWKRvmIKTn0xCmGXOXG2OpNSJANSd
	i4PPXiDhTq4W8u4ZQBll30IZ/hwNVQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <jgdcnclxhw62rs2jb67n4wmmvnmc7l6mnnmlyhzkec3gb6zovp@rccwil2bi4bb>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
 <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
 <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
X-Migadu-Flow: FLOW_OUT

On Tue, May 13, 2025 at 05:37:11PM -0700, Josh Poimboeuf wrote:
> On Tue, May 13, 2025 at 07:34:59PM -0400, Kent Overstreet wrote:
> > On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> > > > +++ b/include/linux/moduleparam.h
> > > > @@ -122,6 +122,7 @@ struct kparam_array
> > > >   *	charp: a character pointer
> > > >   *	bool: a bool, values 0/1, y/n, Y/N.
> > > >   *	invbool: the above, only sense-reversed (N = true).
> > > > + *	static_key_t: same as bool, but updates a 'struct static_key'
> > > 
> > > The static_key_*() interfaces are deprecated because they're really easy
> > > to use incorrectly.  I don't think we want to propagate that misuse to
> > > modules.
> > > 
> > > It would be better to have type(s) based on static_key_false and/or
> > > static_key_true, depending on whatever the default is.
> > 
> > Except those are just wrappers around struct static_key, so why does
> > that matter here?
> 
> Those struct wrappers are needed to work with static_branch_likely() and
> static_branch_unlikely().

Sure, but this has no bearing on that - unless I've missed them, there
aren't separate methods for just setting and checking the value, which
is all we're doing here.
