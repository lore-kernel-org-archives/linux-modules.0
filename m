Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600B2C15A5
	for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552425; cv=pass; b=Qk2kKhzmpGNAhFiyWxBTiCyf4nCRPY4aeWkV4E9cBlhHYBMg6Zi59NtLXGAi6gCA/+Rs+yIAzPpoUbY0EtX34nLjA93hPZ/UegaiaDHef2r/O/rsO3M9d1IbSeGf1EciKfujnlVjG1MH5GgjExSVsIu/ULa/3s9l+LcfVmj2SP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552425; c=relaxed/simple;
	bh=gOIsyGGYeGZsd7+1t35VENt6hUZ6tCz5k0UwrPgrJB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVvvWg/retkM3IxYkuAO9E2shsz8keQn9rD8V2x1H6Dm8ztmWcqqcSxT30JfLJ07K3h86abyTBmWogCdPFqkFU5qupqPH/Bo1fW6+qSVU6NTjytC9ah+6ukIMwQ4zXCxHGQK0XUjp0Rsu6INwZADMtbMUwJcRbpFKx2eMzKRamU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al5TqyfU; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al5TqyfU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d03fcd26a6so1806555ad.2
        for <linux-modules@vger.kernel.org>; Wed, 12 Aug 2026 09:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786552423; cv=none;
        d=google.com; s=arc-20260327;
        b=ctz34D7ntC/IB6Tc+p3PkBt9arUtozoBf7eiTAU9FayQE5GQpPaAAmOOpvEujrWxJ9
         Qj7w9htRZ7FvbmnD4awGhH7zxAXH3Atu/I6dyB2RL5dbmT3GlKy0Rt36QwDLfboRLfiK
         iJPqjEgntKeh79UQWucqlb3ZEDZj3OjbDNA5VL32GObF8OObXmKXRwpKUHwa//YV8A9f
         chwmTHgu/Ohcp92srE8kKpe5Hgnyy5x090yGWNNaTVQA7Jj4bAJetJKCo9Ft6jN4QfuD
         DDMItEcBEW0PSWfjFfDb4CtPeDCC7rGueuxtIlQcgSQiTwljpaIOkLsV+RFMNPdgo+Bb
         wAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        fh=WmwOPqFaj0DW6niWjNip1Slx4d19u3iQao3QuH3m0Gs=;
        b=AR+4rY020e1ClYFtxuZzHhxn3Ve1TQZHI55UIGNsBAZohuG3IlD60KoDMXdY2pMn/q
         sseJ9MqrcqwRoAFo1cbhWc80OJNDWBlmRJMZDqTpJQMpCGRRpKL7qg/OM53c72AU7QV5
         23dw7g6YT7Q9kMdP2VBpgnd2o3LKkNB+NmqGRS71CsIfCE1kcCqIVHiyXXltB64eULnB
         P4XHwM+ceUx5BoiMdLVv1SK/pO0fGMWjuMVttBVeiHqfmL0hpWD0v3ckNBVnikNVjTi0
         yk17cj7dn3xQc8Ud9ybz14i+AWG1hPEL/CntIYaUeK3LCvO226drfuqoPoWtZOUca57N
         qb4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786552423; x=1787157223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=Al5TqyfUu+23OQeZiYehEwCKw9h7n1GWuwvFfs5W/FN6ixV7O12veg3o/+6+ecIG5q
         gi77Jv50TJJVfBr5tK78wp8gBVgj+5Y7A46NSJQiMg9vf/b+171Ld/CV/ytLNCLuYUX5
         JGnwl6csWpus6UXO9bC2cOxNn79Q6o54bdsEtVRm7+6yYsLP6x21sneKJH7rILfD6V6Q
         tMWciyTleAT2pJLtlHf4Ke1yqhLx3FZDQ5GOYVRZdJPiPy5U/KlYo5NBcXMa/AeygtYc
         /sE48ZwkvJJt8DLXaboqm3a/tld2DEUcqAqzzQ8WWBf/PsfhZ7ZNON80nFOWRsL+Ksc3
         WL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552423; x=1787157223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4SZ6u0V1SghQBdqtC98mKtc1SLMxMH5ah0RWt1B7vw=;
        b=Jce8qC7iCILLCK9tczOO3Jcf9+lv9ZfoQVEOsW40GGQmyOlfSeuDid+9LHrIuvNg5f
         m0eCFK4FFV8J65gI0qofvzJUSTtg7IBrLOUDpLqE4OFFIY0u8H5g6OAg6z9e7mBMbfZp
         YVU5sIAx+4cocpT0qUp5qBuk56WMntGnATQpv0Jn5JUsMfalwOMWpaP08jS9A/VHqWCX
         0h+qqUvN2Hi+9TuTb1OSLsjAGDiFp40lxEfZUa08Uhb7L1CFcVNgulaJpFlgdVbbJH6n
         WWF+lWvcnAH+gdNl5T/VpTKH/59M3aIFQ3SKnys4gV5MdeZtXCKEp7AXtkLdyriQJPfn
         9ILA==
X-Forwarded-Encrypted: i=1; AHgh+RrLpFKb8uKJ/ddW09ggWXoBllUf3bzdwEZ7i0VxbX5cLgzt8cAqVOvP04ckAXWdoTMDb9eAsPyZLPTRy98l@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhr2p7AadwMTLhjkU4qKnrzcEbdXE0Nx/QGk2Cdrc3PHVvfPG/
	mQgS7LbaXjDh6r6ehPnvybRy29uDEomTOH53XWu4fi4lAtwy2RG8aVJPRRuG0VZBncNeKB3ahr7
	jlWe3KkniOTZueYLcMtGc2O+yD1DqHIo=
X-Gm-Gg: AR+sD10nvxPpwaPO984Wjr3/3r4A+suyi7u4JOgUd2FP4yujby34G/KIQINLD1dm9w/
	JjI2tc973MTNIY9sdO+d2kUSN8nkBuDJ+bQ2GscvmDqUsckcOb3pAYv3sbhRKe0ivojc20i3ynE
	9Sx88aZcWAMN4wv4FZ/RRs4TT6TiHTV8Q3lCZeFx4qXOhPLYlXY9BbelRi5ZQWWbR2jSOtoARwd
	yeKOVtwy9zxR5AW9OySdiyEPDFqRSekrhrY5wuamI/O6GknEE4IrX2Oa2YLFHnOiFRlRDyN1tQG
	rruGFJsgPkVfXsGngzMYuWxjJzqWSIYO3s2g59PkMxPBrX4y8yuawPpOD+AZk+rSMelBQDPHu/Z
	t9PLVOUtsmQD349t9sSBXQ6PbTkvRu8mc6NVlpGhDLlLUoc27y5U/e6DF1pzE
X-Received: by 2002:a17:902:d552:b0:2cf:9e90:8be with SMTP id
 d9443c01a7336-2d3456e7622mr58880125ad.4.1786552423044; Wed, 12 Aug 2026
 09:33:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
In-Reply-To: <20260811-fix-fops-owner-v10-0-7e71776f9dbe@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Aug 2026 18:33:27 +0200
X-Gm-Features: AUfX_mzHM3XF1m8TGRbbbrVs79_o_CCgi7jI9gpogE6umN7ICq8ixcdhm-skrqA
Message-ID: <CANiq72=bhfofrbdf1qeA380-eWeKj5yXhC0NzaU_nbB9SpxYHA@mail.gmail.com>
Subject: Re: [PATCH v10 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
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

On Tue, Aug 11, 2026 at 8:41=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> The series moves `THIS_MODULE` into the `ModuleMetadata` as a const, thre=
ads it
> through `#[vtable]` to set `fops.owner` in DRM/miscdevice, and updates co=
nfigfs
> and rnull to use `this_module::<LocalModule>()`.

Applied to `rust-next` -- thanks everyone!

    [ Fixed `clippy::undocumented_unsafe_blocks` lint by wrapping with
      a block. Added interim `#[allow(dead_code)]`. - Miguel ]

    [ Fixed `rusttest` by adding a dummy `LocalModule`. Removed interim
      `#[allow(dead_code)]`. - Miguel ]

    [ Rebased to avoid the imports cleanup patch. - Miguel ]

    [ Removed Acked-by and Cc. - Miguel ]

By the way, I removed the Acked-by in that last patch since I think it
came from an older version as a series-tag that didn't have the patch.
Please let me know if I should re-add it.

And since I was editing that commit for that reason, I took the chance
to remove the Cc because Petr already gave the Acked-by which you
collected, so normally you don't need to keep both in that case.

I hope that clarifies! :)

Cheers,
Miguel
