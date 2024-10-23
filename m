Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2B1CB50E
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704964; cv=none; b=SvKlqffkLn+snlWu+ZeqBKsDG7YwFvKaeQ3ggt5t4fHYh7j9bIVO88/Uxbzc0OpmsgrDvhi3nWdUd8H5DDWmm9ksWm56+6ijfds7pmJYyxJbeG7QW87fMrWYyz+wyWxydpLKe0Xp28ZyaDH+zQN2aOPPtsKcWxiAIH90UHYFc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704964; c=relaxed/simple;
	bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4tnTTDlUCQAuQeRW8KzFgR2Dy3Hdd5glLHeLjB/oBtbLtJx9/atg30Xl11oTlpPOnBemRvg0cE2j1Q3iGABwOOVlu0sm2OeOZRVPYVF4HUcCVp5WvCF6e2GpF6cTVs97O5ZhMD3oaSXsKl5Q7NrnNoGYWF8gphiNNXw/XD4j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=GuzX14qk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="GuzX14qk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460da5a39fdso326211cf.1
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729704961; x=1730309761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=GuzX14qkCeGqN3E6465gmapHJB0vk57BfOaf40RmAdF0aZbjq+hYdVGHletdw/bxkq
         cM8XIAeLW8/aU/+GsNUxAVFYDToW8zlSNDMWUrSEUGqG+MWsLZ/amvpTXhabuA6cE4A1
         U8aeBvdgevCqur7ynOaQj7QKBn6gyH9PV39GHFBWxef7gYS8HpfBX9x8ACqJp2CP4n1Z
         DkVh6H+1G/Jjn5MS8FggfFlAAoj9d8T6hfbDt3JakCgXtdJ59bw+rm34kwrN2ayoQAM+
         ofhUJiM+KLYYIhAaAwbo1VxxJUHIR1YiOUOL7a++v+AD7b2+0y5TFG2/ZUUPD3h43CcP
         37dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704962; x=1730309762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spFboIypgyk3XWp5kghVBAFFeZk1pIkBkrhK+B/w9NQ=;
        b=QazKR00dONz8SsNG+kyPcQnw1vcWSGxTTrPCBrvsjHgiZ/VVCozmrqgRkELGpScgl6
         SKGqxEp+nugw7vdOndZSjj0G8duADAexDx+kaR/8ipjdfIHAXcXgKapXDrHx979bw06Z
         HUoswfGy6yyY9upAwYySEs0ODNtJFQzTQmL206kDHyBvUsz6R9Yh7mqdHWjV6kJGCcG6
         rquShSwZ83dJgpPbOESfReupjbZcJMBqWIQ1op1Pmw8MdWhC3dR41kWxaigPIWLRfVrC
         2kKlXzU392v/cqk33aa8xtdX8Yh3IZLzx9rt34YhiftWeTFpwxU6B9iTGbd5p2sWh4zV
         Mggg==
X-Forwarded-Encrypted: i=1; AJvYcCW+EM1Fx5M0xFcjpGmYUFs3JBy0H60HV5IRHnLg1xjWXz9YpZvla+yLugfsMLvQKAaa6Kbds52xWCCKIeWR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoq8uHQNyIbHiFJWrQO6Oqdy0Txbr6Qx/iAXOQVfA5CfRy9fop
	dO67WnRueKVqQfDsKZM/XXG0+K2lq0SWlxbIUupdfdRnkQtYcEYalxejAw5DjlFa+rgDCgkv6Kl
	2FHeIDdcLLt6tN0Fod4wUGd2F9y3jxGXtaQe4SA==
X-Google-Smtp-Source: AGHT+IFV+lf1cZYVfoZTKRitSaDBfAqj+KRGY17augig5JAjskqsVjHe3OvS9TISaOCa0dNfmisxyapMIUhj1oFRM3E=
X-Received: by 2002:ac8:5e0a:0:b0:460:a942:e8be with SMTP id
 d75a77b69052e-46114714d4cmr43850111cf.37.1729704961651; Wed, 23 Oct 2024
 10:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-6-surenb@google.com>
In-Reply-To: <20241023170759.999909-6-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 13:35:24 -0400
Message-ID: <CA+CK2bCUqFeJdWqMiKRNEjWc15vUsk9YAbaLqgL5nAXM8ZkdBA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to abstract
 page tag references
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> To simplify later changes to page tag references, introduce new
> pgtag_ref_handle type. This allows easy replacement of page_ext
> as a storage of page allocation tags.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
