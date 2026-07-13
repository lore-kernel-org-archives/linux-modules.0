Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFF23C8731
	for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933076; cv=pass; b=SnkXthm6WeCAO8qtIPvws826/nTsrCGP6sdCHMmsWSptqEUU9U1rZjBFCpRTc6EGDT7u6sxXgXPpA2gqohoTy3ohC+0WmxUaGW5u56sm0cTWix1a3/CZwSKXXAHJ9MlgXZUf5n4EPM+9TA1+x2B/+yNDxicUc4i1BOkuA/5X64Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933076; c=relaxed/simple;
	bh=zGXlgemVtM/fd1QacjWZsPwmu1tJ8IeGxyTqkvyGisI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5LtOBHXRYvQd69ZjVETYMgTpFQtIkVuhMyC6HR8IW6fTbghRm0rEt1Bl/mN0sPsHhNVOQP1UhSopC/QqRyEELu9WimL+Phb6OqbVCocYjsqEk2cOk9h6S4tmKmNvl7ID2zoDORBt14bajIbDm2ycFV2HyNxUV5nfs5F3Sv2zzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhZpWy9p; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhZpWy9p"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4703bc0a99aso1555361f8f.3
        for <linux-modules@vger.kernel.org>; Mon, 13 Jul 2026 01:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933071; cv=none;
        d=google.com; s=arc-20260327;
        b=aDPyVEZOLECGszKV9WzHcb0qvaqpIwrek5cTG1WV34mAfzZBYASU9HSPcbQaCqBX0d
         SipT8xsHU3T+Nblf3LBA02bjazLhlqAmzc3yGEjzMEHtMaZPDhwNAqz82gfDp3RAad2U
         Payt2c1ggYkJQh+F8gzRt/f0MG/m7mtGeF3cmizplOv6dWxQMWmV8FG4EpKjTFs3DSX4
         PM3KcorUX5hyHvAknBqxTHAzLpolIJ6VgGF81JwuiFmGNU1uRg+bpC9cY3Qw2FDylF3z
         V9v0VxFjD1HQi3OYwDk0grAD9ce6PaAurwPLZz4S0/28kw7+pO3M+h5Z0aabdRm/LoH/
         rLcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        fh=KTc01nrd3Q0gyTE5Xdvi2ouV0Ge/xJncUkoFUgYM9Gc=;
        b=L1bIEW2rmVFUwB49aewc6XEvnW7uztWarfDTa+eYFu2ds0x3N17eicS2rLRCLhgeXB
         vutWMUEatTRzqAc7fgP0iRNFBYGs+uhwvRY+hQCr8BcxFwXTKvSA/GbzlL7V2nAwJ4sF
         w+Rk4iwtJ874XVqHUyrNOfHOeACYDicgN1tU16I7wRnJhRanzvQRlKs1tRPEee9HvR+d
         R0KhuxmhHtGAoWBAibNASEl0dLCvdYsXMo4ZCTluKR/RnRKlUjITMngszDx0TRgXzmCf
         FyHKJbGE+BU6nDIorX0u50bC7ixraelchSZtugVkrHvFumbU2blvzkyHN+6uldrTYtsb
         ATgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783933071; x=1784537871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=bhZpWy9p92MsHXolXEEEzyqO6a8taUshJqNTLDakidqvhciCwPleXpZnFFjlWiYgu2
         PD4KtR4wi8mFviwOMoQsSLwoiUrgbFxzrfMzPSO3Sybm9n1+9I9aGIKm/8G9v52bT/Dy
         /ECgJDqbQXnj9gc2kOfy3eG3Oyas3PdEqt32qqoJCGj+tlRe2CTAPATVLVaT2ZBSLmFE
         6NLrPC6nlM9BaqCBTXA2N+qswyb64G3vtCx9kHyfA9GDzZl//f+Oby1N7yx4QVQbPtoh
         MUkxAek+4XmOD/fokqGCzy3ZmMRVg9nKjm32kMvJgFt/LiXZSc+ZvzDDjsD9s3OVP1/l
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933071; x=1784537871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=Bd9Mve7bHjA//kx3oWMCx/KfYa/MEzdJlbmIDlvoPCG20XlyWzgzNJvtx8iMF6sOBB
         bZwS+J3+sOEVw9xO26h7/gSztPuae6Tvi2N0DraCsgMhv0N9RojIAd2pxVWhEEq8bRJ6
         bUVEIO854B3pmBlrKafeHfP0jSZQ0auDzlOsciPiK3VgZgfr7uhodQzalkJ6E9AN8O4B
         1dM7JBXg1d7l6+6QxLQ/j0M/kujW3w4LnFqoY2G10xEWMd37e7STcbVhaCMgYF2D+B+/
         yyV9MvhNdMYGQhyfG67y4NdqQjuAhm0EdsbGr/wKm+U40/jtekHbKapgMGPRHcM3RJqR
         QxTg==
X-Forwarded-Encrypted: i=1; AHgh+Rp48Zxis1UUlBn8QbyHkIdaRc3V0T1pE5/4edIeBX7MdvVDoxY5gYqDeXjRM5qoZ5hrfkTjjla2/P5oIUP7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+dqCAeTQPT4YgppDMKu6lS4hGnzios+Qdtwd57KXjgV2E50r
	usP7HouwwzyI68cmsftkiNImJs0Ih+n3jUuZ9dMpD81ky2gI1ltj/JQOlhr4fgi7KT+ZG2tK2XG
	kc2tagl7V7QYvTzkFx1aT1NBcA7y79v6KOK4OS8Bh
X-Gm-Gg: AfdE7cl6slM2TcetZq83fiVKnYrG5LSUMH+rsgLwrCTTo9IiSk7c70N+U/Yu8YnCTj3
	qP465kp4RPpReNbj2C40T8UaPzZBDdACpzET49ALBnQeq6qh4UNTq9QWxdHmJKm/T0kLfpyzlFT
	pX8p74xlO8nMJ656fiI7RXlEw/0RoCJr1vQria6KW33UvLArUlUg+Optq4sTlBvHaocgZDdWiXB
	TN21HNcnAsZvJcPJR7WyNpTYvoI467IRMz27Wtm/sXVxuU1YBhgi3GEz4CCCtP4QeScXOECL6oc
	TAe69vTE7WS04QZX6cFoBS5R0fRC7d+mTwCZAMEqux6jIukkWerPcs/TaLq0ONPzg+yTyA==
X-Received: by 2002:a5d:5850:0:b0:472:55a:ef9b with SMTP id
 ffacd0b85a97d-47f2dcac418mr8602513f8f.8.1783933070140; Mon, 13 Jul 2026
 01:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev> <alSe6PsvdrSYP_Z0@google.com>
 <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
In-Reply-To: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Jul 2026 10:57:37 +0200
X-Gm-Features: AUfX_mw1uUYgV4eMXkVflbUYoDKpPh-OOQHMx0yAVcG6yUMQsdEhmzk4SLg_fQ0
Message-ID: <CAH5fLggszOnUm7Rykt41V91de8h9YVaZt49wr52i3t5-QV84Xg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
>
> On 7/13/26 16:16, Alice Ryhl wrote:
> > On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> >> Module types now live in `rust/kernel/module.rs` alongside
> >> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> >> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> >> files are covered.
> >>
> >> Cc: Petr Pavlu <petr.pavlu@suse.com>
> >> Assisted-by: opencode:glm-5.2
> >> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7=
d21c5a1a1b8@suse.com
> >> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e035a3be797c4..74733de3e41ee 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17984,7 +17984,7 @@ F:   include/linux/module*.h
> >>   F: kernel/module/
> >>   F: lib/test_kmod.c
> >>   F: lib/tests/module/
> >> -F:  rust/kernel/module_param.rs
> >> +F:  rust/kernel/module*.rs
> >>   F: rust/macros/module.rs
> >>   F: scripts/module*
> >>   F: tools/testing/selftests/kmod/
> > Is there a reason why this is a separate commit from the commit that
> > introduces rust/kernel/module.rs file?
>
> Gary asked the same on v6; `git log` shows MAINTAINERS changes are
> conventionally
> standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate.
> Gary agreed [1].
>
> [1]:
> https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.=
net/

Ok, that's fine then.

Alice
