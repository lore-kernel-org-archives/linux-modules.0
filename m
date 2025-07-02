Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F92F2344
	for <linux-modules@vger.kernel.org>; Wed,  2 Jul 2025 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467847; cv=none; b=T6+9BB8PRGYl9vycanLDs5kGPecfcQYLU59d6BmLL2cREd9ZMJnPkyecnXAJnOMws2PtWYR2esEio548YTqoIquqv7RTZZLv+Gw/9ncyNCo0k2oyGYKN6aolaZ0Ksd3Cmn3+hvNunVamzOq14IeQMOR7a+f80X72CCdbvwKlpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467847; c=relaxed/simple;
	bh=bGDmRbJlC9g2n00fZnTFalUFPsZkCq3Xcia/+S1QojU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6nB9NcXmzeTy7+irsm+9Q4jv7UiGNgOyFPQPPg3KsFa7UGPnEwQpsv/MiDy81TT/CF8183uZWMwfPKP+v9YfnfeFXpQF0lFxSOP97WIOILAO1g8ZGjHQZAVzASxLtrknr5LnCXRuttQWszzJXSPEPnVhiKH9zX+Ea9kdYTobMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fl8eO+hr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fl8eO+hr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d7b50815so34631605e9.2
        for <linux-modules@vger.kernel.org>; Wed, 02 Jul 2025 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751467843; x=1752072643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGDmRbJlC9g2n00fZnTFalUFPsZkCq3Xcia/+S1QojU=;
        b=fl8eO+hr+B5/m7SMDuoL0hDElM0F8Ng3rf5t2KhFFOAzzQEDtFyWslG88Z9QqC5Sf5
         7v5DYq6xk7WQb+8mfmHJCk0v0CFqoQLidHvLrWYFzTe+EJJEBxj8XcO5uYrabIB5GC4B
         m59caVfTNNCIVvk0PtCTarYaCEHQHQlZoWe+ITVR5KKcQPAyxMUSP5Pi1/LVJk/ByLPf
         9fMrIcTep2isSuXSuX2VdiOldY1TxIP9DU16j5LJBxL9MrpjwNsj0/gW04YQnifnL4NL
         OIC9H/TBnmN4GHQpTksKjWXKagqy80fwgQs2D90pvli0Wl7kI5gJrmKsGDIzFnpMG0Ld
         jKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467843; x=1752072643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGDmRbJlC9g2n00fZnTFalUFPsZkCq3Xcia/+S1QojU=;
        b=C6W75K2P6h4LETyMRhpFsqahd3ew2sthvxvWqfgFmUcNatU0n+5mA0Vqc40kg/lNfR
         3sRHBjOgsWdahfFkrC/lRNSDMCSsP8ZyqH5BflV4VaE24OzfqPIV0e/Tr3L/TZJm4cdB
         y8om8m2icNYh3c+JovPvHeam61ObFrYeU6q+5Zamt1aprEQUOD6FhuAF0rJtfEGOk3vS
         amIh8zfXocX13T49n3urKutSiSd75rXNhyMDq8SN0fOL5HmVX1+hGs+vw5jaDD1q7aJf
         3nKTn/6ZystN1+qRrsDtVSf8edsUFAZP+wQEJioy+MiYCdhQnQfK14aNgPZlFAnUlyn8
         XssQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcYsmHlS/eEnzVYSZ21KyklAwQlQMUvL5L0Xuj5F33SwE31LmEykyn+9Luim4k+mMJ9W6jIke4hlNbqkzl@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHISbZq8RJk+wTOTyvjsbR3f5dXq96O0WsX+Awo8kZWaogf31
	CZa2/7wkU9XIrp3cqzcfzOnbc9X6ul+MjemkEAUkJo4YC3njg8ABElSWWCrpLMFo3l4DV/Rl5lX
	wuT1GUT+o4X+kmaOc9kEgm6gvHuLsZnxCyJQ2Qv0K
X-Gm-Gg: ASbGnct31oVxmsf4SUI7maDAI5nv+OiI+KfdMBgQU9EWq/wjJfL5D1B5uuYaizbsdoy
	hgWqhnF4a8f5GyJeEMQtYjUmCXuIxjclwntt5hN8m/kFT9BYYbN99jlGHFe6w/n4ho4bwPvG4yJ
	u7BLgPH4Y7LOzMUBHMRRC8KQgyuPcdb3qjK+NOaR+G/Yb5
X-Google-Smtp-Source: AGHT+IG+nGGlVC1LAKFybNU3aqbmD0eZd0ceRrzz5dRVvQ8OU1lPy3YrwXIf80CODXdFzmMy/vEJc2Ci9DIJm39I9S0=
X-Received: by 2002:a05:600c:1c94:b0:43d:b3:f95 with SMTP id
 5b1f17b1804b1-454a373259emr30006825e9.28.1751467843001; Wed, 02 Jul 2025
 07:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-module-params-v3-v14-0-5b1cc32311af@kernel.org>
 <20250702-module-params-v3-v14-1-5b1cc32311af@kernel.org> <QU7IDrQqnXyNZDFF_jgZ4qTsRLPmUeeWedU_T1i11uOyc1E83Zo4tETj_oPxSfJySNZZ4-XEVBlkZJ-MZech4g==@protonmail.internalid>
 <CAH5fLghw5TDrzmFZB=tORR5Lxx4WoG4wer6y5NuFdod2_tb6zg@mail.gmail.com> <87ms9mvgu4.fsf@kernel.org>
In-Reply-To: <87ms9mvgu4.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 2 Jul 2025 16:50:30 +0200
X-Gm-Features: Ac12FXwuZ185xGqP0rxNGwOW-SGS_WRsBbvNFuZzozirA5KDsx5bUbkVgIxui7g
Message-ID: <CAH5fLggY2Ei14nVJzLBEoR1Rut1GKU4SZX=+14tuRH1aSuQVTA@mail.gmail.com>
Subject: Re: [PATCH v14 1/7] rust: sync: add `OnceLock`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Trevor Gross <tmgross@umich.edu>, 
	Adam Bratschi-Kaye <ark.email@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
	Greg KH <gregkh@linuxfoundation.org>, Fiona Behrens <me@kloenk.dev>, 
	Daniel Almeida <daniel.almeida@collabora.com>, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 3:54=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Wed, Jul 2, 2025 at 3:19=E2=80=AFPM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
> >>
> >> Introduce the `OnceLock` type, a container that can only be written on=
ce.
> >> The container uses an internal atomic to synchronize writes to the int=
ernal
> >> value.
> >>
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > This type provides no way to wait for initialization to finish if it's
> > ongoing. Do you not need that?
>
> I don't, and in my use case it would cause a deadlock to wait. Anyway,
> it might be useful to others. Would you add it now, or wait for a user?

Waiting would require additional fields so it should probably be a
different type. It's more that we probably want the OnceLock name for
that other type for consistency with stdlib, so perhaps this should be
renamed? The name could be SetOnce or similar.

Alice
