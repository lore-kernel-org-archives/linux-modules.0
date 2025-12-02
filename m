Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081373FF1
	for <linux-modules@vger.kernel.org>; Tue,  2 Dec 2025 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643835; cv=none; b=bLILvNWq0b1MCnfGDy/pPwGguudShLeGQvRkVC5Dx2g5rBQPwhepHnPbeS8qf9dGm5efRf+geb8wWWtA796AaT1PRwjiu5hEg9Xvlldi7pm/r9RizxTWLVA6DZUTBRzDl/3pYB1wOh+hkoMItculMrJHRdu6IHOgK+LQVAuJKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643835; c=relaxed/simple;
	bh=d2nnb4UTXFIkbAdN29yEdBrzizD88vkgBJQyyjX28+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvlthWpd4chIRtfaDy5a5HT/lBrOyAOUd2dMa9EaWHNt9sV8gHWvHqOJJOxXg4hmkSoBMUFJnb44Y5hlU5xN1IEfoYTPflD+W4uDbyedyb9uW0stjDh49bLkd9054Nui7iQES4OJwQVpQYtD4TClyh5kV9xO57taEGRuT7WdNHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFwCF64F; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFwCF64F"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640f88b8613so3609895d50.2
        for <linux-modules@vger.kernel.org>; Mon, 01 Dec 2025 18:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764643833; x=1765248633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u4fZQuQJ65AJK2A7tpNQAB3pVThD3W5ngX9pcfsdMkk=;
        b=dFwCF64F5ApKy/c7oic3DFCfhlxY79ZJFYL1RYNJly2kyEgfdezaX5AymvXHWNSkiD
         n4IIC2Vl7ILl9zpc8RBfXPMtN1f0G873VSMEG51A7i35P+I24BWTtRoxzE08iLfxVXiA
         WBVv6qTs8na5DhlUoR34hGDJCf6103kIjo+q0QuTnT2+KzXzOT1vpLPpyhL31wlOqMw9
         BC6Q+wWzUMxd9wYxQbrJWYmYTCFGFKERT3Yc4Yo872wWZo7xLRQJXRWMd7uyhIQYLhpy
         Yz0/fF+2jertz9DGPgc/4hEmujAzs07sWKk5ggzCcvSvPVzPwfH7L+VLm8zTVNrFmB0Q
         nT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764643833; x=1765248633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4fZQuQJ65AJK2A7tpNQAB3pVThD3W5ngX9pcfsdMkk=;
        b=nzHgvADIODwIWGywzFAaydwmhOfZbu5FlZFd64jCJMncex343s3fP+nYaJO2QxjC47
         RiXoOSuiC85/gTsMl3CSgtQtCQB+t76STKIn9+WQjpS36CBte3RMkfsba0+MoXoFZxaS
         VL3LORGi1Wi+1SNSfp3kDyoxsY/l3eRw7CeZsH8lxBBmgb1++7F6FBCt4cG622XZUjr+
         bfBZ5K+JXmzaboRWfJV/41X04GoxXu2b6uixPHkfRaZh/r/JW2oVvZO+QVfp0gI+xXrI
         M9cT8bKWfnrPtU+7CWR3Alwk1uTeloQJiDiwCW27LH+ia0x2tluzeAUpuRDwyJrE+3pd
         pdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjP4ul6IQwcJm27aX7sp5y1dENNs9jFbXu7nC7+EQn57pNpiEW05uPq+rwPwKKE0LTw0aQytlwL8ehrAih@vger.kernel.org
X-Gm-Message-State: AOJu0YzFm9Jadj89hobBdT/cXWzBKVs4mdvRQOXSqpYA5ayaQ+ceh/ex
	dter4Gvga+NXMnYdJtotCQsrAkhNPjA60/G2OlqnMEkXyVoNVS6jNqsr
X-Gm-Gg: ASbGnctbxyf8SBmiYZetaZjNqEfJjHx3x0ZjhcXpqNJlDThk4e0P+pI3RA8FOtLOADu
	ohHbXn6BygLk2shg0VnLxjKgrJz8a2YpkLjzBBLWejYWDeZiLnSrfDiak4nUy9bMutWUc6n9Pvj
	LvAmDGMDOBMWxBn6cZbgCjl3U3R+PAch1ORPW/uNFwDQxdWXO8GDgQCOaO0F6wimZSFe7UzUB7Q
	Pvfco3QXxqCY6DrefZhRycJGFthNq0VOEBrWf+40x5HGFLNueCk6O02L/ztdFfmRx2Y5eHLZ687
	ceDxk5xQhZup3e9fm7yS+GH0QViuiT1QV9fTfmM5FK5tchmAXZ0idxJfVRsIqWi0NvwvTEdnSK7
	PEyvdaO0PeoP40wkN81cut0JtkYSb5PcPcxyrvlI7fKbNIeE6cd53ijTEzVl/wB6V436PPxv053
	ZlP8DN22E=
X-Google-Smtp-Source: AGHT+IFvjnC2S/Jp93rH0uVWc/73vRFOoYQepG4E9Ug5xxnCcXms6vpoqWinBuFed3GkRDU5HYh1CQ==
X-Received: by 2002:a05:690c:2781:b0:787:e9bc:fa1f with SMTP id 00721157ae682-78a8b54d8cemr340242637b3.46.1764643833002;
        Mon, 01 Dec 2025 18:50:33 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:8738:665d:bba8:afd0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1043a08sm58083027b3.52.2025.12.01.18.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:50:32 -0800 (PST)
Date: Mon, 1 Dec 2025 21:50:31 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <aS5T9-1z7PK32q9R@yury>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>

On Mon, Dec 01, 2025 at 10:38:01AM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 29/11/2025 à 20:53, Yury Norov (NVIDIA) a écrit :
> > The macro is only used by i915. Move it to a local header and drop from
> > the kernel.h.
> 
> At the begining of the git history we have:
> 
> $ git grep STACK_MAGIC 1da177e4c3f41
> 1da177e4c3f41:arch/h8300/kernel/traps.c:        if (STACK_MAGIC !=
> *(unsigned long *)((unsigned long)current+PAGE_SIZE))
> 1da177e4c3f41:arch/m68k/mac/macints.c:          if (STACK_MAGIC !=
> *(unsigned long *)current->kernel_stack_page)
> 1da177e4c3f41:include/linux/kernel.h:#define STACK_MAGIC        0xdeadbeef
> 
> Would be good to know the history of its usage over time.
> 
> I see:
> - Removed from m68k by 3cd53b14e7c4 ("m68k/mac: Improve NMI handler")
> - Removed from h8300 by 1c4b5ecb7ea1 ("remove the h8300 architecture")
> - Started being used in i915 selftest by 250f8c8140ac ("drm/i915/gtt:
> Read-only pages for insert_entries on bdw+")

STACK_MAGIC was added in 1994 in 1.0.2.  It was indeed used in a couple
of places in core subsystems back then to detect stack corruption. But
since that people invented better ways to guard stacks.

You can check commit 4914d770dec4 in this project:

https://archive.org/details/git-history-of-linux
