Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C73537CE
	for <linux-modules@vger.kernel.org>; Fri, 31 Jul 2026 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785480382; cv=pass; b=MyCcANK4v+efVU/L5IYvXdHPrPaSAcnhyUVEmC7mOcMERZCxxS/IW8FkR3mRDQmI+V1l/rTeGdy25ZlUSE4HMxtM8wDslLAavwErFKIv8F3ACM1vkEOaXzCrshFPAzPpXZK5p+HjtJXcarjVGejPAFa4WGjRkhx46XeUryh3WoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785480382; c=relaxed/simple;
	bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcg1xjDOhmkPt8msz+vLPOA4eeZugodliLLSInkMZke0ig42/j3lJ6CVqOrD7fPlcHGyb8hczWVxkrdbyFkL1bMbcp3vW42npoRu3IJwBmidz+BXakeScipaA+M4gZGXrndZPTfxGLnIT8vFZchJ6ur/KYvd+P2naYdDMKiR+zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHnR1d8I; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHnR1d8I"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdce28edeso694135ad.0
        for <linux-modules@vger.kernel.org>; Thu, 30 Jul 2026 23:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785480380; cv=none;
        d=google.com; s=arc-20260327;
        b=bTMNECdyU1kIY+b2lfHvIDtif5IEVC2GOdwLpKFtxAlcoLgU1kGR99UkFcn4ho18W2
         e9QPK5Gj1vU48DoMG/YVDAIuyv8PNt/bI+5qBf5HTeewcnmohEFn0zgs9LwJoIKBRgME
         FY2FVPxprSTvcbHRkLqm5Kxe1Do82TSf0T2Qe4cXZ1aUe7w/oaLad8XGKfG5GIGY+K7E
         uNowyV4SvWqENiC8e1gUcruaapJ2lXRlkHxQD7ttn1Ip7yOFB3AKrwnZodaHLB+4Ve4c
         IjGq+T5B7xa7GBmOAF3wEyDTNqq3NtuJQgi4Xq68QqK8JNT2yF8q+JdShoAx4JJPJU5h
         SGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        fh=G4CNgTZFWwJgtjdjYXACfYTk86Nah7qtB0fX8v+UdCw=;
        b=oigRbDpgoCVe+Wt43nFbBms8oD/jfJ7482cOiithUazksP7etTgYDsO3/Uqce0ZV1R
         gHNLK4Zl0WCdrbEXEVMVkTp72Ymery18JmKAfEPEvoGfgSodrMKuh/OH9RUAuf6zhWeo
         agw2lscVla+FP6RIwNxQRby3b9tDHHaiWtslYmDYTxi1SB3VVRYkDHbgIJ4DEwGW043s
         46MvX+63h5t/V0wFmsErTB8XEbNOIOOKSXsasO/j8XecVJJ9ixKQVHXV0LQ+ccKywLhK
         Gng3pnPmIlvafSI8pHu3fJB6tPhfiUFj71k9sk/a2FT0Onptld7peQ3HdikKO5yYYZh/
         pmIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785480380; x=1786085180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=QHnR1d8I/TMMKJbGJJ3aw8izZ7RG5URa+aA4KhAZbDqkJRLAM5u4XN+gTfEheCPRqB
         2KMZipuxAp4b/k4FTiHsqZKYgtPVQyY5mBzOSij4/2JFMQyMisjb8doiJWaGsIkBKgOu
         svJaHDM83vcM4tByZM0OZxbgwcmf1awtATooPE03M8/RPgJGUd4Lj2eT14WW2vHwl8uJ
         54X3B3SOEB9R7nncrk8sPxZC9BeDLB4h2nFts0jSJTlrjZa3D+Deu3V+97jE4J1CfZ/K
         YZFqt1ZbXILwW6MbA2Z2rvJxKWwpkWpyYduUHgls1FbIhiNDInIIo0WBGPyiY8nRozVO
         4VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785480380; x=1786085180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSWRSbOj71BNGeOr+HBxtLFfbntXDiooltzuw+HXglM=;
        b=cU/wJdiGDqueu8Qzx13CriXecXBmV3RtsEZ2+d2hlY1NdMRfUo1mn6y0F7s1Jspnqu
         R9Vm7gk8z3jCvJ5hjrFAmLy5kqDBMpsQYqb2exKwyd3fNI2tOPAiu6lLxvfoA0+wsNSp
         l8lmUgGowDcFAyFsnIxuF0dPmq/9bo3bQGqDZIWXpErVEM16npk2eSbtRreFBFHMnqcc
         K0uvaarEuSUNQQVVQ09Kr4exMk2WHzPLhPEoGe5POdLsH9+M4VORPzwVyZvE6sPQRoN3
         Kf9vO2KaY67a5pqJ8gGx8UPqtBDwnDeRZQUvGJo3dKt2cAaSfsnuiZEkuPpn0WKiq76F
         OQEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5co4o7dCG2cQ/X9NxhMsdeHV7x3dPCj3C03jAx+19hK4RX8EdBnH5LlaW2Ce+ThdfxqDuAJxj/zbcA4jF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZCXcCG6qlfzSYTeaq9m22vM+0qBEbyr/5CTNuSowwuHpmxnd
	o4D6VMhGpLu6NpVoghYuUC828dUuL7Ynv8QLh+goeg+fFg4xGa/gb0NIp2g8gU+oVLM5Z2mXgJg
	gUCdrh2fdHjEuaB4vZkiBK8BhYdesa+s=
X-Gm-Gg: AR+sD1043xyJy7/WUATRUDJ/Fz6D0Tk/p/nsPlEg69ikgAO93O0oAW6eRzMHnnfXmSY
	O8V1NZ8DiCYnAroR6238goaERTUfqycW+FUL47PfNVtUZVZc7LFOmj4/yYPu9uPitNy7AzuiY82
	TNC3okCuqmsGZioowkcbSrl6k33cJS/76lQly3zCC3tee/LtaPrU2mo8mOyHCAqEnSe7ZSyb4u5
	6ONDyqxCsrkOQAC4gUXCy3LWx5XH1xrk58GVT7D7uyC1VmV6lNHsRqySK7qPhYLMqMybtG3P+qN
	YoAMgEeVDNuHa/xM95mef8ShzCYvGJ6sFYeq4DLK9/J+ic8j2GFO40Iavj1nexXrDB4pWuGV7rP
	tLfSwafpF+ERVvq//JB/kCha8ErhmgJ3UlUgyE0Hld1QUxq30Cys5b2LhsS9e
X-Received: by 2002:a17:902:ce08:b0:2c9:b96a:2855 with SMTP id
 d9443c01a7336-2d046b459b3mr15748155ad.0.1785480380480; Thu, 30 Jul 2026
 23:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
In-Reply-To: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 31 Jul 2026 08:46:07 +0200
X-Gm-Features: AUfX_my5gmBTyBxP6uEcBbaVDtTCrtAGlQbEryzjfR6FoeX2UBUc_vHFPgNtGlo
Message-ID: <CANiq72m59O-ruHUvUcZC7yCvu0KV0w_m5vMO4e0rxyHdRmihJw@mail.gmail.com>
Subject: Re: [PATCH v9 00/10] Fix missing fops.owner in Rust DRM/misc abstractions
To: Alvin Sun <alvin.sun@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Thu, Jul 23, 2026 at 4:11=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wro=
te:
>
> base-commit: b7e5ac83cb16f7ffd11dc23736f84276602100ed

Was this old tag used for some reason?

> prerequisite-change-id: 20260519-miscdev-use-format-9ab7e83b1c11:v3
> prerequisite-patch-id: 405b334ff0d48ad350014f05a2321bdbaa025400
> prerequisite-patch-id: 604b631c81d5423f4ebb2e12ba2d22e9ce371bfc
> prerequisite-patch-id: cb550d94cefe01920e0d3ced2b2bcbecd76f3907
> prerequisite-patch-id: 3bc830839742591460cb86d9472c04f4686dc600
> prerequisite-patch-id: 571058244bc8c7088638d2e3225713011246c7e9
> prerequisite-patch-id: 347c5a3c6dbef9832bfce8419fc23e6e08ba477f
> prerequisite-patch-id: 3e202d988b56b88446f7535e90d3f00cf5f15701

Are all these actually needed? Some seem unrelated (some were already
applied too). The only one that seems needed has Andreas' Acked-by, so
I guess it is fine.

(By the way, I will use this second message to take this chance to
move the modules maintainers in the To: in case it helps, since I
didn't do it in my previous message)

Thanks!

Cheers,
Miguel
