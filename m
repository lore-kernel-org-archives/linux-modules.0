Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C272326D45
	for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681928; cv=none; b=KQJsr2XSMvo8HF55cCsDwaVmYstl0vsup/ky6xatBmCqySlwAOu/CGsLrkEgBeuiYF/hblcuJLEngBQv5WestzPMi3ZmNb6ixVBHybrnfxE1QBq3dC4go3CeWPKOZKqDMBSiousKTcM35v/k+G8L4I6ByIEQvTg2xvj+CUgyHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681928; c=relaxed/simple;
	bh=a5fm5PyeXCPgtwIg9w8CZw9qWuFeu25iVj9Q/e811YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFHHzi2fqosdnF87hTBHDpD9UNYRQXHjbBQBSIpEWugbkdqSEVw+EFeTiHMdK63VDGtcaSxfVuUYHf0xvtKuR40z1jc8h6FgeBgOdphSg4rynJqh39pAaxsEEFJsOOjkqkrrDENZp72SSuuNwNk+PeqA+XjH+RO5ORnpgFD14J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sq65owoc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sq65owoc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b052ec7176so6305ad.1
        for <linux-modules@vger.kernel.org>; Mon, 16 Mar 2026 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773681927; x=1774286727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEoMPSWLlB9I48+tiZvbvrcTwB3X5od00xQklbNhgN4=;
        b=sq65owoc+dP08uUfXe4T/hEABtnyZTjElLsQrTP4d31ZZ0GBEGm8Gvqgmh5CBpRo+Z
         hh1wYu60LkBhXC77GYNrD+Wl3zmASvgnAUM+Zh9zVUafi3IyJXxupQUwoM1z59xhbwFX
         uMFNtwuL+N8Gx8NzSefhem+rIEdLqa5gJPB35xn0n+9ab6p7MzvUclD6yHcQH2uuNkHg
         7R6JV68DKVQlxI1LAb+uMl0Pq58i/XnIHiME3aRRzU6Bq6zX/8nooVNwKkbfIZh9E186
         0p7/huCLAezbVMxvdHVAFHliz1ty11iKR/S0xRSUsSZPLFQpYyJLiILMNG68JsgDN6+0
         4V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681927; x=1774286727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEoMPSWLlB9I48+tiZvbvrcTwB3X5od00xQklbNhgN4=;
        b=JOWFJkms6iAq2u/hvZGRkjxkIjWjhaBBgbIsurs9q/I0Us4xLWWTPtq9BbwnpbsGfa
         VAhYP1x8sQEkXM8OIN+pz0EfHYeJPaB7mST0IhawAalBPmpVGRvxvqkKwuaDSJhgHJ3w
         nMUUbfF3rrjtG/5WS6HCQZsaK3VcLPHwom9vaS07/+qtXaiku08M9s7dfxEsSKKGA3OD
         e5yRqCUQvr9ViRMyZH1yI0oslYLOwp3XAApNOVexZonTllWRlYhhEfHKjkWIC8WOrwDB
         DHlkEYvqqhN3j0A3375kBLhhdeNmMOpC00I9M7RBWhOzFUL7Bbc2AAn0ym8RLllanbcj
         y9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWriID6jlQ5KpUp/QQA1mmaaI6MMQcjU4EbCrn5ede2NlRUyIKgJjqf3iAyaEa5NuR9leZbi1CsqHcNCO+s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1z/UX3Jh2NMfhCQwe05uNPvbOc3JpUQ/LJs7YZybmuW+g15do
	YUBch3QYIxk2AW/SsD6YLs6bU6CPWqpSZTA7HWfLwAXye0KtXWFQirCzujheKWsZUQ==
X-Gm-Gg: ATEYQzx7CfV4oDJGZAgGF9wdXG7mTzzd0i058ohfnR+b/FCsQt5qR0GbDd0TPy1ZJi0
	Ld13xqFEWD/TeQWO7ZUpuRc7CkPszBb61VKP9v9KVLkbQh+vk57lZSwu2qJ9IuhPfeSCjwuYXp+
	zo3asHrT+AvLWQdeCGlZOSIDw+d8Hui8Spxd0f1VrMTzi8cGHiUuWW9/Y38g5eNK3CtgCMu0DuC
	xQ/4qRiyJ52kr9rmyjXErx0zARIpaOIWO5AbE9mzZcqgQVFWHzp8fXRSLARVEF/t/QHVPF7D4qB
	0eeQ0vxFwK223ezlk6K/94fdhLh6g1g/yNd4rfyah0AhmtEyG87EkcH9XpUy8jNi9CYNk+R/I80
	1K+WD3chpZx/tcfLJjue5MKFgrkfXfF7GlItgqA+gLQ5zpLvhSDDbkgcFZA2qgpvxo9ESKscSmq
	uwV4TZN417n6+edzpJGN2n9o7+X3M6IPZsoBKgfv6F7X6F3hibzv9aA0kB6pugw6Bnxbg=
X-Received: by 2002:a17:902:c947:b0:2b0:55cf:5e91 with SMTP id d9443c01a7336-2b0642b34b3mr10455ad.19.1773681926446;
        Mon, 16 Mar 2026 10:25:26 -0700 (PDT)
Received: from google.com (197.23.125.34.bc.googleusercontent.com. [34.125.23.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c740000056esm5873565a12.24.2026.03.16.10.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:25:25 -0700 (PDT)
Date: Mon, 16 Mar 2026 17:25:21 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>
Subject: Re: [PATCH] module: remove MODULE_VERSION()
Message-ID: <20260316172521.GA1300047@google.com>
References: <2026031341-evolve-repeater-987b@gregkh>
 <2026031303-prelaunch-creation-3fce@gregkh>
 <f036410e-f53c-4284-b108-18bcdb2f0d28@kernel.org>
 <abfGQUxgm8mEWlAz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfGQUxgm8mEWlAz@infradead.org>

On Mon, Mar 16, 2026 at 01:58:41AM -0700, Christoph Hellwig wrote:
> On Sat, Mar 14, 2026 at 11:22:22AM +0100, Christophe Leroy (CS GROUP) wrote:
> > > Sami just pointed out to me off-list that maybe I should also drop the
> > > srcversion stuff too.  I'll gladly do that too, does anyone know if
> > > anyone even uses that anymore?
> > 
> > If I understand correctly the text in kernel/module/Kconfig, srcversion is
> > added only for modules which contain a MODULE_VERSION.
> > 
> > So as you drop MODULE_VERSION, srcversion becomes completely useless doesn't
> > it ?
> 
> Looks like it.

Looking at modpost, srcversions are added to all modules if
MODULE_SRCVERSION_ALL is enabled, whether they have MODULE_VERSION or
not. Doesn't mean it's not completely useless, of course.

Sami
