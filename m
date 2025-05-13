Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391B1E4110;
	Tue, 13 May 2025 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747171489; cv=none; b=OG/rjwHrOKrJhL/T0mLFWspHw0sUPKZsFxb6PFx30FKfeoLe4kiL535nbCK5VPbEszI2gQQY/p/OJLSvw3d7n1fJ2aDLl+GgGbURy9Rbr3s1olfE7nvdZIRd4adFoXdNa+H22lAYil0tS+4qmM9Id3ScpoWid0CjH99kwtYtJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747171489; c=relaxed/simple;
	bh=hk0cbMVHZxXUp2hmIOCvFWkmmo8gPbS17tBF5BieMZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASPViwh5GsPMEJ/fSrMNdoWRsMcG4vLHtXiA0DNjstd/b9E0u8rwfJ93BGMf4epS3YiEjZC6I/da6bNqX4R4u/zcZqpxwqHcrhgxglJQR0rOg391Mqm1BytkQiGdMSwpTc5mmC9yG3LhbrX/thxy0LcoDPhf1Iuda7RXSswfcSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdURjXOt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdURjXOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57491C4CEE4;
	Tue, 13 May 2025 21:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747171489;
	bh=hk0cbMVHZxXUp2hmIOCvFWkmmo8gPbS17tBF5BieMZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdURjXOtAK6eR0X/6SeXw55wpx0vXLLs81ZP4VKQaW07DuaBGo7sNSioTNqG/rcO6
	 4rX9djsg/39GqEv2AuDjg5NQoUsEzU5ZWgchyvkidodLdLLep1X2pKhy2HBlfB4Yrl
	 AOKMTMB74eQzuyXVGsZ+stfwSyFDxlo4wjTaKicNob6HU+22W9xq6MxCb/m2rkvMeM
	 ocx8klcoYgTbYmggZaJevEcltQbo7mDYU4mQABupBQDUGfxB0UMVGefxjIInwo2Yqc
	 o2MEoXBQHdQmNrNt+UEkl6CuxIG3iHL8WFjwegehCCaASX3FDfUQpdT/Gtrng2LmPU
	 l8Ev43pxlE+Kw==
Date: Tue, 13 May 2025 14:24:46 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] params: Add support for static keys
Message-ID: <zgifi763q2zdj2xn2535daboorumz4g64ospsukp4e6btmosir@xrbhtw777ytw>
References: <20250513130734.370280-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250513130734.370280-1-kent.overstreet@linux.dev>

On Tue, May 13, 2025 at 09:07:32AM -0400, Kent Overstreet wrote:
> Static keys can now be a module parameter, e.g.
> 
> module_param_named(foo, foo.key, static_key_t, 0644)
> 
> bcachefs is now using this.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: linux-modules@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  include/linux/jump_label.h  |  2 ++
>  include/linux/moduleparam.h |  7 +++++++
>  kernel/params.c             | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index fdb79dd1ebd8..0fc9b71db56f 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -107,6 +107,8 @@ struct static_key {
>  #endif	/* CONFIG_JUMP_LABEL */
>  };
>  
> +typedef struct static_key static_key_t;
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #ifdef CONFIG_JUMP_LABEL
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index bfb85fd13e1f..11e8d5c57435 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -122,6 +122,7 @@ struct kparam_array
>   *	charp: a character pointer
>   *	bool: a bool, values 0/1, y/n, Y/N.
>   *	invbool: the above, only sense-reversed (N = true).
> + *	static_key_t: same as bool, but updates a 'struct static_key'

The static_key_*() interfaces are deprecated because they're really easy
to use incorrectly.  I don't think we want to propagate that misuse to
modules.

It would be better to have type(s) based on static_key_false and/or
static_key_true, depending on whatever the default is.

-- 
Josh
