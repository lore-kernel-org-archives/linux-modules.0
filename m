Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD124679C
	for <linux-modules@vger.kernel.org>; Thu,  9 Jul 2026 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606434; cv=pass; b=Xdt8kAeeHlsr/uYKMUmaY4wepJd6Qx05cfWlXElxk0WNMWcCEhaWd81iCzkHT+Si+ghI2bsDQ1HgtEbA8lHno6Yf/IyqwnyariFgyZY0dbPP6RiWW2wTd9kvlBEY2iIufNG6PXvfw96eazqwkWBDaF65/xh0/rsFnWLkDHp5pKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606434; c=relaxed/simple;
	bh=THIwa+RK6gvfbtOhXyQCS68FClxcC2sC4koXL97cyKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ki1PQZutDx2icx8RnhFlg1TGf4Ec0tMLLk7cQboyMJ3iHM0dlLeBuN2gGspdr9dQEQm/dSYVNeAArlFflN2hD1+cjb06cAUr1atMvC6sS/rb8p7xH1h+nxU+yWeRNifdngfvheX1vibzDBbRnpa2bqvA3ERWWwxEVyZSu7Ym1mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOjtkRex; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOjtkRex"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-384c94c9423so248984a91.2
        for <linux-modules@vger.kernel.org>; Thu, 09 Jul 2026 07:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783606432; cv=none;
        d=google.com; s=arc-20260327;
        b=V/hd/QNN9W2JNIJGprRKX+Jgprkyzntvw3qBSZ/8POtHg2cR/J+RRje29RCkYgNiGV
         F3syDswCr8Kcgki6LmZpmb/x3IMsAj4IqtOR72ZRofEBFWp44OuXXpRgcp/1RcbYYpjA
         dD0loZIcFy5k9rKkCQz5I9b4i3fcJ9CKDMwxTeLFrKooHDemHEpB71+UeGM0uEhjYYgu
         xOpjTlEqnd+fwcOkmVzAkWJu87Pmd1GDwD9l40IBcogomPI0MVBQaPQW+20Ti/Egrjy1
         y6wUC66Am/Uf9BPuGe0SeCQ2t5fzoe0n4PgzpTdARzZd7pwd2xqBZXxAEsFnViQio8wP
         xpkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=THIwa+RK6gvfbtOhXyQCS68FClxcC2sC4koXL97cyKo=;
        fh=3BKuy6rBEg9fauDRvgEoEq/p9dcV+3myp+B2VGemPiE=;
        b=JMSML0L3A+bhUgUQmbw4Hzw/gmBBN1o7P9JamQGPm5Cri1p196PJ9GrOtrQLQuteZX
         TEkH7UnY55+sg+JrKsBQ8HKBxrEJylOlo5YCAyJSqp8GkMYeFcf+m3zqnOZIA08RwAMI
         56U2vSiRsmthISBnaw4w5zAtiHuIgin+l9dw8Dl6IffF7I3DcJHB49PoZwhQiSDk4ien
         0MEaPUCc5JKaHor/S2J4zglPTwnSywFJ/Zkb4uZuPYOu0MnR9EHum4tVXhelqRqlLLV7
         Pl4bJYyA97/E/QoLq/KqqDdeFKVHfBfmqShGcJuAo6cc8S/Sg7sU9Px31CXogbtdRCA5
         qvdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783606432; x=1784211232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THIwa+RK6gvfbtOhXyQCS68FClxcC2sC4koXL97cyKo=;
        b=LOjtkRexhHEfA2ZplKeDiPtsf46UwNkZUT0P5zEba8i19RIJBD7MrVG0MWVpX4JstE
         BEkeE2eRxcOvehB7VaLPoduUbDTLufNvbQ4cqnWl8+BGipGjNg9L9641qAHJWBKDJPJL
         iIzNffgyOza4CWsXZ8ffFYmfbzVTk2yF4uo5gLP3QZaOMDnjus2O56ROZiriwqweHqvJ
         8LHmEauDqelHrWbEZA7Lw0BSReDfM40wI1L4R/BW9qXgcKWyzldaQc7ftq6IFrO7CyXO
         00oT0lCSKyU7ZqFHSykSlH41Iye/s/fGts9LQZUn4SM4IvkjfB9KFsowdM5PLbQx0GyO
         UhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783606432; x=1784211232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THIwa+RK6gvfbtOhXyQCS68FClxcC2sC4koXL97cyKo=;
        b=kYDF18RnpXzBp8jb4pbxU4JcfellxHJ5NWEwfZ0rOJzdF2/NWP2jYAvTJ5Xb4kGbcl
         dbAEo+FEQw4TwNI74qxenbAnM8z4gMqKmsn3zc9jxpBPrrnWRfqdXKdVqxOgyRWhnimY
         9ATD+U5Gh0x+ix/Vf23jwHdz3ukW8PblXyx4LW0hDIe1sIjT5KePZsYSg8KRVIzZltFu
         /d/PMkJqfS9MbUC2RiQGmoYtZ9SH4HwMyUUQXFtZB+YB9Uz7d165SGvBAp8CUrVRIdbC
         cVz35Evg8+9QQoLvUPiqY+CLUJU/brMH//m+ZksWjczFxDf67vC3lFLFxq6Pc2uKmz7Q
         Z1Gw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5mjpdLIrAhNLKAqtkGj0Ep5r9A2k16YJ4MbZdpxUbhHskaqrmNK1pdHXjWqdzrOuLVDXeraQWd4LnfASg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60gSRZA1/iC7b9g4BM3eQNhaDVqiOYCU/NSDQBnQDDG6RtkU0
	jpnk23GO2eYqhmMmK4nFLkAzQo2XB7eAcr//02dITpbmpKanmgurO6dNjuSyz+S2UTU5fPE+2Xm
	tvyLk3zE2pWMkIaNNgnC1vdzdCtSohvg=
X-Gm-Gg: AfdE7ckOHFCcVb3bvNEnG/NwwdfSXuPNu0fQiko625T52z+KZ/W/Pdbet90ZFjLM/m6
	DQJ+Bjzj4FYfAotEBJLPuHdIVxGOwhhiEuSZTyNH5eBNchabnmWv7gOMYCehYI2XtGIeZix7ofn
	S1TbRBgP9UVjHN4TC3nL92IqSfg1KIzU9LO8LtAEaxFttYyhgssXOPDs8+BU6X+vWtjtolwY/Cg
	SqpDGBPyWI+nQU1Gr9anyVIBZt4El9A+F3F/FGLm4wavPc0wdz1oypnZ74/omw94qzokYJyamNU
	Sb3dF5bNYGJFisY/oMIQJPGFUauOqsLSKJMUZIo998oR3g1K7Jep5FMg5wBIuaDQ8N8mqC8TagC
	YJs2QmKwR8tdh
X-Received: by 2002:a17:90b:5886:b0:381:bcfb:e710 with SMTP id
 98e67ed59e1d1-38a20e414e7mr3741911a91.3.1783606431960; Thu, 09 Jul 2026
 07:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org> <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com>
In-Reply-To: <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 9 Jul 2026 16:13:37 +0200
X-Gm-Features: AUfX_mxmqn7_OUUAoJ3yj63oM47R7thf01Kt_RIaWnast_nQWj7WfkIeu6L0i7E
Message-ID: <CANiq72m3w7L5CmAsFvOpSh_jNk4jL8+A4vz8GEp+E8FY=TJcRA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:48=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> @Miguel, please let me know if I should take this patch on modules-next,
> or if you'd prefer for it to go through the Rust tree.

Please feel free to take it through modules-next, of course.

Thanks!

Cheers,
Miguel
