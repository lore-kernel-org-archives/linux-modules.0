Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5D79B7D
	for <linux-modules@vger.kernel.org>; Wed, 28 Feb 2024 18:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143523; cv=none; b=hiu1AjPzzA+IFy8PnLEEqDmJrQmqyK1HVSr7CoW9zb9xrYKoOH3yCS30S/d256/MsdUeQCwfLv0i7bcnWwkwXP28psU6okpQoyjrILUd5nXiCHktakT7hBlshKHQIGNbhp94lGXQn1wvxdqU7C2ZqwtcKgzkJvRHrCoJ9RNKLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143523; c=relaxed/simple;
	bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSqyJoyqsoNWvVpcrtPwbKSMOS5yb1W4zx2Ab0zmUnBJVvWB+bc77qKJNipNDUxMYF5Cmymbr2IQaJckR3g8fuipE2qXoDFt8lQPuAITW5OBJuNdBdU64wYml1r5IsV9cUbTOEgDKQnpHPiE/qAAAvZSvJuisQsA3rfIArKAx94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Nj3u52; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Nj3u52"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6093b4f82ceso245067b3.3
        for <linux-modules@vger.kernel.org>; Wed, 28 Feb 2024 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143520; x=1709748320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=07Nj3u52kU5HkNbHmQi6GSJlFvm+hwSmH23kU9J3YIdBUAZcfVKU5HQ3RCYnYic0v6
         QLRHfuCjI9k+jiAG3w+DoaSoumtOezIBDz1r8Kz8fHtyP7r7SZx31n43NzTdmop/PO2A
         8mM/4NeVzeoWdN0ez7/q13ruSZDGpAfWv4C6Jt0Y0ZDccQI15hWg5epL5i0sGXGwRR2Z
         QyHgs217g8YnqC7+n46M+BhjmuNXp3pKxFMqFRf5dLwy6cELVZXPEu+Ogd7PlX5F4r/Y
         GY/qYMx/nxnzCGNBgbHCEaaY4EPWcJbvRoW29RCrocuMaX6hzZjZnlqLuzHzfEmrYQi9
         uEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143520; x=1709748320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5RWLefMMZcrjC6ohvg7ZMSlCbzmM6eu4zL9kM45cas=;
        b=fpxw+fPk1S1g79FZYpkNO6WSlGlDMucEXdp/bGsjzURlXCcmGIkWiJHyPPtjrdBS25
         2j35W5HS3LU33E+bbzZxEwY5qcQtAV61UBuZL8hccKB8ADvhxFebkY3FEX/6PDQbDUR/
         HKrJl5WJy7AqLt0KnWBqGaU3OQbGwAkiiA9btEkzRLNmdD3xWWpln3qTSGHf8L2L+br9
         zZO6hPiE1jXfuMdqNchavPNSlcWztivD5otjgUy8Hkg+JBff7GCOuSTPP9SXVgUmaR1Y
         XDaOMSodxp4Ff+XzuhkgXCc+/YxYoE7N2y+hjmoBADjwTME3QKS8gRImBA2VvDe4aKOr
         hIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNS/1Vl4wqA9KkxFZ1xz0ZZ6sxh9WI1SKYb4Cz/K3Zl+Co3pO8J3ksQd0Gyy8p2dlMnyEPgZKNVJoXFrMGy10WXXAqu2kZlddXphLYuQ==
X-Gm-Message-State: AOJu0YzU3O3yhLMtaQjutpjqCmhVZeiyDqprfFngd3bQrJ2IokJT/06r
	ujQvM003uBgCueFJyvyA0YMTR3a3n8FYko4sBnyxuEW22knG4Zh3nVb26Dn2NHgXJTgK601MozJ
	71DN+W8WZT/SzSYZPws9Td1NOLIvr0iTbATgd
X-Google-Smtp-Source: AGHT+IGXC8lezvXLfyLFgurkGO2/8+xbMmbLbWU2Dhx0X772e49nOZcLM0/mejcqQER1kvdSNB2vVup4Slt3VEZ2U4I=
X-Received: by 2002:a25:4687:0:b0:dc2:398b:fa08 with SMTP id
 t129-20020a254687000000b00dc2398bfa08mr21101yba.31.1709143520037; Wed, 28 Feb
 2024 10:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-15-surenb@google.com>
 <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
In-Reply-To: <1287d17e-9f9e-49a4-8db7-cf3bbbb15d02@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 28 Feb 2024 18:05:08 +0000
Message-ID: <CAJuCfpGSNut2st7vKYJE7NXb6BPjd=DFW_VEUKfw=hGyzUpqJw@mail.gmail.com>
Subject: Re: [PATCH v4 14/36] lib: add allocation tagging support for memory
 allocation profiling
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 8:29=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/21/24 20:40, Suren Baghdasaryan wrote:
> >
> > +static inline void alloc_tag_sub(union codetag_ref *ref, size_t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
> > +static inline void alloc_tag_sub_noalloc(union codetag_ref *ref, size_=
t bytes)
> > +{
> > + __alloc_tag_sub(ref, bytes);
> > +}
> > +
>
> Nit: just notice these are now the same and maybe you could just drop bot=
h
> wrappers and rename __alloc_tag_sub to alloc_tag_sub?

Ack.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
