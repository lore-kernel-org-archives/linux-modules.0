Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6A128387
	for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550472; cv=none; b=FxF5zbfCtRJkAFhjAmqxBGDjEiP6IXDhB4SLwfD6oWNQHmfQoBP11qV3LtbyAeuNIQjerXmpmdNMMSwK98RB11sYNY0mrnJDMSlDDaJL1aIgg6Hqa8A40CfEaDXKFb8puSR7g8k8vNJB2qco/OCVsecLRdXiNsDScAT3tsDeUpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550472; c=relaxed/simple;
	bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NoLjfz8qpiEkJ6vcnkt2XGV3J9O1ele/HlkA1dI27Bk8hTER9ja4mIArpzjgbESXIZ0Az3U071rgi/wvUZTnGuSip7/kowZfLocPfP5+XZAyNRGGP7YEEwDL4+AzzqkC3hgvnXtyH2I4AiIl1X+w4et1oTBX7fBNu4P1BSTetOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=JxUB1ljL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="JxUB1ljL"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42dd9dfe170so25714021cf.1
        for <linux-modules@vger.kernel.org>; Wed, 21 Feb 2024 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708550462; x=1709155262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=JxUB1ljL7XvovtiVCEiIV+ZgtEh/WCr4kltgFFgJQOX/Nze6UEOtT6SfoHf94oS5jO
         F3PgJkRi/OzC+uTdyAXVDZmtuBXx1QevUcedfG5duFQQZh76wbB6L3+KWuUhGIpLKmeg
         lE+A8eFEnzaYCiggTXZqyAlSoc8Xi3sSVCBTwEevS3Nb7Wvz9IiH3Mvo9QqvuKM1Exzq
         rmwxKg2TCPQiLQ4fmnLgyPwn+aTdMq13ksJqrR7dXfzOnHvMAEgoLrl3ha+pGyxeENnF
         JY0D23vKekg6Y0NHqqHpT8rjyB+aP5mxYFacnV4aFLgKRoeUbHuCMt7fUBTn/1Ola9MY
         AQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550462; x=1709155262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFD4yQzqaLEAi4PA03QBYwNo3rIHnJT2RUQoKF+C/Mg=;
        b=aNYg0ifqI063UTgQztCkKm2NIJAhLosZz+A33TL40m/RPF5JupQBCQaMDQj0YEAPP/
         jOPjTvzQ6i4E8shF0cz6NfAaJAUgkIw3QmXg8NrggrBHdQ0089QlKiA6W22KVojxdEyn
         Cx0CX06mlv8sxFBi7seSVJkJFZbLvlSbEWe+0tfiS7gCJ3+nkmQV65HZKk6RDgd4OKqg
         ueJY/mYHpg8fX7PLE449oqJ4nR4hkFwKR/BQfagDairxS0z7KPvWMf6E7LaLxcKjv18F
         sCsvyD77ZileoJ3Bk3IZRDaMGczLv4scUm71ZH5dD/6a933q3KEofWDdnOMsfTc48FeQ
         5dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkzh3Thnr7APlJuY6edBjfjr6UZqxLQlY7tdtFyFXgUqDBtCrqXeAKw3uW01ByozJVBfVYZCqpZ5WVOCPC45kksNIsXQapy5xrGBNa9A==
X-Gm-Message-State: AOJu0Yw2l1ZgupRIyHVvx/KPuF3n8LQhbGrOhphocueT/lvNdNYUzGWC
	O4ftEdqTPjORl2vT6f3OU4OprdsR2323tWoOwassDnzKu3lFdaEP7Tk4LSChf8ra11he9TDTBKl
	3nj8kghrJ4OSwNv6DyWbNjwbEUoNu94ApK0ezgA==
X-Google-Smtp-Source: AGHT+IGJtekCGEzDieaihS15p2Hc5EreGxKXqPCCpXJixs6Ac2iIPaw+nCtg/oETMxVwF6eTa85a+lNh3bwEt5JkkGQ=
X-Received: by 2002:ac8:5981:0:b0:42e:17d9:f8bd with SMTP id
 e1-20020ac85981000000b0042e17d9f8bdmr9654015qte.24.1708550462298; Wed, 21 Feb
 2024 13:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com> <20240221194052.927623-5-surenb@google.com>
In-Reply-To: <20240221194052.927623-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Feb 2024 16:20:26 -0500
Message-ID: <CA+CK2bBqUV-mTOYSuDCBaMjy+HyEs+=YnY9Ay9iQ45mStSn47w@mail.gmail.com>
Subject: Re: [PATCH v4 04/36] scripts/kallysms: Always include __start and
 __stop symbols
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
> From: Kent Overstreet <kent.overstreet@linux.dev>
>
> These symbols are used to denote section boundaries: by always including
> them we can unify loading sections from modules with loading built-in
> sections, which leads to some significant cleanup.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
