Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84B2F2A;
	Wed, 14 May 2025 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747183035; cv=none; b=p5++mXzWMD1TikomsQo8nbZOXHP7ZyLFNIwT3dzB+ljyalI22gk1MCYzovpgMOcM3zJ9RJ+RH65Jl2ZgKSOdnUC0xGBOVFBy6SfHUY4glaqBVyIotEM5eviXMKVF0tdBDpRge333CiI+vLpuA/AQ5o9mZKXcnLuIR5HzSqlalUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747183035; c=relaxed/simple;
	bh=tBZ7Zjra4afuQW/OJ2M6y08FzyjLqKdxMR4GGS5kfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAHpKhw1ZJqI5M0i2r++ziCKOkFYME3n8mI5I9DYaFNDmqfBkQLIbA5PdZxU5ZlZlKNo/mTnEAIL0BPy1s4lX/LZganDpzooaQACCQVleEZaid+taSw3jNhscOWr4kwAY9GR7Vo1+3YEGt7q/f/O39bBCqUteO3izFZCvfHkamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5LaUCzT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5LaUCzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65681C4CEE4;
	Wed, 14 May 2025 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747183034;
	bh=tBZ7Zjra4afuQW/OJ2M6y08FzyjLqKdxMR4GGS5kfHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5LaUCzTt/Me5vPRPlf/4T/VVqAJuD+c9nqDUsm3/dJ6N15R2vHsJZEuo1ja9GCUX
	 BoE2mIjyl8nBPontkTXGt7GWovpwLJXJguXn9Cff7PukmeFDQDQZ/ITweC/GMSaf2j
	 yUJlUTVBabcB8hJFlUyF3Eal0XKYCxDBgPx4/8InD1zHNkA669+hAmHLe0khiSxhTw
	 0H5spUIqwyWL5NyxFZh9ZK1de0rVARWHCQSu2hx/GJDi3EAD5aww8l70rhgJs4Zx2n
	 Y56/ZTj4fyh4IyztXI60A+SxE8QtD/MGCEytrIycqciUg/Rnryc5bWdSAryDq0rrPV
	 B4aUdQIXvuFeQ==
Date: Tue, 13 May 2025 17:37:11 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <zljx4swb6eyhf67kwm32gcfboedxvikige3p5c7kt5lqo6c2jj@jjoa4g6375re>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
 <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
 <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tjqz5spozvd35egxtfn2n3csvqu2qsaobbkfzf52ovhsokq47y@eq5xl2ugyydq>

On Tue, May 13, 2025 at 07:34:59PM -0400, Kent Overstreet wrote:
> On Tue, May 13, 2025 at 02:24:46PM -0700, Josh Poimboeuf wrote:
> > > +++ b/include/linux/moduleparam.h
> > > @@ -122,6 +122,7 @@ struct kparam_array
> > >   *	charp: a character pointer
> > >   *	bool: a bool, values 0/1, y/n, Y/N.
> > >   *	invbool: the above, only sense-reversed (N = true).
> > > + *	static_key_t: same as bool, but updates a 'struct static_key'
> > 
> > The static_key_*() interfaces are deprecated because they're really easy
> > to use incorrectly.  I don't think we want to propagate that misuse to
> > modules.
> > 
> > It would be better to have type(s) based on static_key_false and/or
> > static_key_true, depending on whatever the default is.
> 
> Except those are just wrappers around struct static_key, so why does
> that matter here?

Those struct wrappers are needed to work with static_branch_likely() and
static_branch_unlikely().

We really need to get rid of old static_key_true() and
static_key_false(), they don't have many users left at this point.

-- 
Josh
