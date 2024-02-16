Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54643687
	for <linux-modules@vger.kernel.org>; Fri, 16 Feb 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102020; cv=none; b=t9T9BiZDZXZwzJ2HVL0IGkrWUoAuYmILhZwX9DO/+sdMn3Q72m482ruwiDkP6+KLR/5tffzQRu8CK3tLhOpGOcmfOJWziHt9utoPKGpAbq4SQ2+gnMCbRS7N74n5IT3Dxtzr4vN9y1uan45YXCIHLshotuSJnpG/2BJUI5fkwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102020; c=relaxed/simple;
	bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6MVONZNMTNLbeetHd7SMk7asAHta2HXgbqPtCyscZ8vMIYkBDuhplzMCmruHYj9d5zOiu0RoqLGnl8eKAbkzTHsIu4qr4f9F+0pONhh9EYybVbD1IvIAMdlgabtRuLcKn6l76LwLTOpSWGubhzUjPwL8xyEJTyoWCV0RcGp4n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyzLVMnD; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OyzLVMnD"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc742543119so1038208276.0
        for <linux-modules@vger.kernel.org>; Fri, 16 Feb 2024 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708102018; x=1708706818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=OyzLVMnDCE6jz4Q+qffCh6Gh4iWQJtQHHBHNJHFU9nOqqh5XY5J548bB3HMg+pqoZE
         wj46/z6t6lXNQh9dj8V54j9KaGAle7I+Y7tvVVaN6koEplIwc3/Xx1nySgpkoEb5Im2/
         DE5Vow6Od+e2urKCrffkKdJ5Qtu6IHsfBCg3S167TZSkhQfQDYF0KCEfttJy2vZkewdA
         4L29cUOQiSv+Ytc+NB/3Xy4sXBCAz40WEeqswQISFsbw4tgpeCiG9Q89YvDZYkg3VQdq
         VWlbGw4TJ/ibTkC5oEnw2jWyVxhd5z9qKbWOk/VDIZStfJ9x4gQwDNeyxUREYQ+UlLVT
         hwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708102018; x=1708706818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5/86K2Z1hDqoZIqP7XxaxYaiR6tJyE2BrZYnn5TkeE=;
        b=wyg7srlxwqRKzSTGztjMj7AxdIZ2X0dMk6AHzhPVpZu40MDDsvwdETUw8dpR8zJ5M0
         CrpNUJaT7NQgXA4MFbCrR/IuvqIGBE2l/neOLHX2HeaaEXdC+ZoECGYQBhHmUhWS3SDS
         UXf9RZKiWnWukvEaa1fTUKfrQNcWlQKyKhRP1FtqMU5uzt1957E/2jVbTQPZ2QZJArIn
         s6qF0tlf8gqW1ypQm9AZiFckyc58xlFP6HrsUugdBrCAWDj4K2TIF5ljSZC2AjxUXPPl
         +g9j2Hf+5/ul81t4HI56W22oIbaOBa1L5hO7EphX7aN5b+PQVfg1pIKKJgf0eS9JG9VN
         WCPg==
X-Forwarded-Encrypted: i=1; AJvYcCXSiA56HTPV2REVrHtUdauxYcD0p+q5bD4i3rF7Zdd69yVMYgZ3xUASQDJZxgH6Ju7ThKzCY3Pg8oX7/PXy7xv5yRWBpzDP6VxamqF9Ug==
X-Gm-Message-State: AOJu0YyQgbXXtAjEyZo6UEV1GLt+4lbmKwAzUEY8+nN5C/QnD44Jcvup
	FgW8dRDbSPfHouuqsOE5r86eAvCAxleHPL3NZcV2gaFJdmNvIWbu216sMlKRYWCMRIvUxhHNu9k
	CFp31u6sOCMMqn0y6Bk582aku054IKYZtftMw
X-Google-Smtp-Source: AGHT+IHpVHS0ppvETjTRvFKcu78rYESIPuQ3727VZfvfJc5knt0q+oxLKdnegsBYKFjwcpEUJdgoCQszaHZUroSf3Gc=
X-Received: by 2002:a25:ae44:0:b0:dcc:6894:4ad4 with SMTP id
 g4-20020a25ae44000000b00dcc68944ad4mr5406936ybe.56.1708102018033; Fri, 16 Feb
 2024 08:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212213922.783301-1-surenb@google.com> <20240212213922.783301-19-surenb@google.com>
 <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
In-Reply-To: <2e26bdf7-a793-4386-bcc1-5b1c7a0405b3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 16 Feb 2024 08:46:47 -0800
Message-ID: <CAJuCfpGUH9DNEzfDrt5O0z8T2oAfsJ7-RTTN2CGUqwA+m3g6_w@mail.gmail.com>
Subject: Re: [PATCH v3 18/35] mm: create new codetag references during page splitting
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	corbet@lwn.net, void@manifault.com, peterz@infradead.org, 
	juri.lelli@redhat.com, catalin.marinas@arm.com, will@kernel.org, 
	arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
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

On Fri, Feb 16, 2024 at 6:33=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/12/24 22:39, Suren Baghdasaryan wrote:
> > When a high-order page is split into smaller ones, each newly split
> > page should get its codetag. The original codetag is reused for these
> > pages but it's recorded as 0-byte allocation because original codetag
> > already accounts for the original high-order allocated page.
>
> Wouldn't it be possible to adjust the original's accounted size and
> redistribute to the split pages for more accuracy?

I can't recall why I didn't do it that way but I'll try to change and
see if something non-obvious comes up. Thanks!

>
