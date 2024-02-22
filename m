Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55141869
	for <linux-modules@vger.kernel.org>; Thu, 22 Feb 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708560637; cv=none; b=prLjcftxelqQZkWp3a5UswtctwRZOtm4gTmwNeUDhUq3LpY6tTCIkD3QazsCw48XI1Oy5UgxzwLEpxKKiGxbp8d70ppYx35QGPvAwUD7PxcrRxu6E73ZLGtKPTBBv47Hur5KGxkvJqb2a8lMGPLIszrLRgdiYUqimXzXusGorcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708560637; c=relaxed/simple;
	bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsP3xLIxT8UFME2hU2PIKHAa8rFuJAXXgnJJzjP7Z0mqtReDOQUV0bJpbCJ2Rzg7rCJTAzMYL2TVbU67W0jxjLc86N5GXawCEI05DheTlVcECvGP3uQ1hm2Vt7RWuZOzj0UtM/1zEoB/+5ZAIauN825R61xFsjWi7ceJKhFiZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=WMqOTNgo; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="WMqOTNgo"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e1a0337bso3762352241.3
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708560635; x=1709165435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=WMqOTNgoyIMy5Skhg570/S9RfKRo+GGYJCSxO9Wx46wIXQMWTS2sf3E2BFDb9cb/Mi
         SqSc2RwztXYNSaB38gztWThpj5wG20etefD5/vzwCIiRM3djvQYDKyWZLyyB9HFAM9wd
         GMQZLr7NXKp6GOaIasT2JvwkONeaUgvXWnQcOrKHk1+ub3kdjAL8tbRRBT8znhaL2iy2
         quvghVEXB/K/qztLQ/o/HGZdmDIRYb4aRqmqlbUHD9a4EgJ8wr5jPA/6XG4Eo8myvR/W
         T/TCrdyLnp6jiwDXmMDE+CSg3Midm+48pxiNe04wJ4IpdOsHW8Q9uLnJqcwi+xwQqlmf
         Orvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708560635; x=1709165435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1D0pVaWMlr8hskhdGaW7hZtXBWle1reW17x7OUuU9Uk=;
        b=gi2N9Ep1+gdVAUSifEB+O10d9GjwNxpXhIL2Q+brg2Z9OYvYItvg+4wK1qo3cY/Y32
         hOGqyckpbfntXbI2IKp4FfS+L2EWvagW4OkcfNO6Yfq3KUS4YLHBIpYuwYLUuB2kX+F9
         ElkjS/OI5ASsvZxa/RwG8L3Jd+a0xbpjymUhMtSJAV7SRcsyBvtMUvk3o6Eq0+K+YATf
         Em6ZWJqkkXxrcYaz7ZfjFbFNKfoq0bm6toFAJ6B9VmVZ2dfBof+uoNii+ltFksoYSwam
         kh0oSCZO61LYRbuaLX6JuFKSSS6eM0hDlRmSnLr9RUGWM8/e00EkhZ00K1ETk7MIIFVz
         vVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5saw/mD+VOj6lGQB6wxzW1tL2ko8r2eFaboSokUZEI7+SmAenIMTXW81A3eK4Wxad6dpIsgHRZTba2LfsV/HRJLIU7UttAsyQ/SahQQ==
X-Gm-Message-State: AOJu0YzAC6p7NjLI4K6jARF0ft40fJGY7ooLDO9m1Bb1chhPGvOstYqe
	sL8NJKhU+dFktDwixKPv3+yZFW5m7zYWkuP9rlI/BuNBP5C7rVI4V9QqglH2Ins9jD6cygmfcon
	vYiaav4EDidD8jWN3dg6o23wjtbcBnVLH/i0lHg==
X-Google-Smtp-Source: AGHT+IGvkzT3uz6qELPJtraK+YKtQ9uJucd+Pri79etJZSzYbQUZmm3eTGpEAZMzRr8Ip545g98kCtUJT9vyheZUmog=
X-Received: by 2002:a67:f54a:0:b0:470:3ade:af52 with SMTP id
 z10-20020a67f54a000000b004703adeaf52mr11439980vsn.6.1708560634875; Wed, 21
 Feb 2024 16:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-10-surenb@google.com>
In-Reply-To: <20240221194052.927623-10-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 19:09:58 -0500
Message-ID: <CA+CK2bDWkrNapWD7pv47XQo8PD4qJ3O=U99pL3o72KCnrzpsXQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/36] mm/slab: introduce SLAB_NO_OBJ_EXT to avoid
 obj_ext creation
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:41=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Slab extension objects can't be allocated before slab infrastructure is
> initialized. Some caches, like kmem_cache and kmem_cache_node, are create=
d
> before slab infrastructure is initialized. Objects from these caches can'=
t
> have extension objects. Introduce SLAB_NO_OBJ_EXT slab flag to mark these
> caches and avoid creating extensions for objects allocated from these
> slabs.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
