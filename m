Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76354331EC4
	for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704848; cv=pass; b=lKQxFYuNKHE9n4x64hVFsRpugM/7dnzkFqb4paeypZ/ivpvFxlaZkfj2L98YBGfWlHX1pYIiyTYme16eSrwAMZVa/gJY5O6FaIB34Fu4bUylRtD+tg1HZJdWRVpitGlELTP9dt/60T+cG3DamRUfYR4i5XZkhaYSn/FnCbOEQow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704848; c=relaxed/simple;
	bh=LxEPjIVzrHW+ecMfzuce5pnKRet2GQcLO4lMpP/KG8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lggNVTqXnuxH84mRCpiWKkF6SIdcSYmtq9Azy7kJVNNkPunlr7xKaDJtSRrWZjiOiPsAA3zlIr9UWrAWR44Te9AqJ2IWx+pd67UcarF/HH1DBiLG5KrZpdnv6TEquonm64c6kTzmc2saxvU9vMuEx1N7LQPXbZiWrZNynk8/A6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEhC+gcV; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEhC+gcV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-380a02c71e2so524699a91.3
        for <linux-modules@vger.kernel.org>; Fri, 10 Jul 2026 10:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783704847; cv=none;
        d=google.com; s=arc-20260327;
        b=PHhS2AiFoAuPRMVnXlEOdyLvRVAOFMH3WITsQWcMxAWb1V1SnGAArkXI4rhX+VuzKV
         7IT9moZos3tBXj3Dxsxa9ZnyfuWYp7dJ8HAsBj+AW76Z4XVkXNRYoDIZsE+33TNorEON
         HfYDS/ETK1hAPXb+E8/WIYwdqVVvQHmRgHmFq+UaUn1MjR6D8vhgAyDRXsq70VqhZFTm
         q9Daqpg62XP/eE3aCXIXe26AshlLb8ClCrI0qZvctMwT2cVQ95TirMF7aAfZblLh0oGR
         alM4EeySHjXljGiFt6c3P2L4E7qM61NbevGPnjdeH7synB7/GYdkREHZRSIFkSN0ty3N
         NhGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xrN4t+c3+bp30MOSjaFcq3FvbpeuOxTLajWgTQ/N4Hw=;
        fh=u/1Cyme3m28IkMOqtFR7gl4PQaFNq4ELsBpAMR6bObU=;
        b=G/hq8Rl5WYTAdiAUlh+OfQ/KURKJ6nnz3f/sFvU2AdO2vnZMZwgaiBjAA3nT3X/EvH
         Q8AwA2AcVpVWI2/QlGYbefVOZFiy9vORbHdp9KuPRsQpiljtU304eVXEhJWrT1bASE7h
         MMocvEPnh07bUs6oClDZjPmZ358iLHgIsqaYofOa8lsqVsTPc3cbmQgZhFoQ31whRxPP
         d1M9HtBXsEnrtPhf5Q6h+O6wbGZOMuiqg6zTn59VQCtRc+sV56m0s74aKnPrqP6b/K+A
         Ql+ygElo5a/Uwoxzsk9CdQY5qiyHXVaW7bg+UCO7T6okWowaLyrANR6g9ebiWfYVF1oW
         yBAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704847; x=1784309647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xrN4t+c3+bp30MOSjaFcq3FvbpeuOxTLajWgTQ/N4Hw=;
        b=iEhC+gcVw+nm7WqUFbLQOWWrCsMnoiXbYR1ssAZluqwOTL1fRw81ZdUZPMp0G654M/
         Z3k+fUzjHNkg6eQ3sc0/QgB348XeoAZ0nNTPE8TplQZxfbtOElWnyfYrdDRRgVSYAxNT
         xNFttw1PC7lzMApoLhZ7nlfTXmtwwF95kKAjbXttY+i9uEVU/sz0tBXSTqh3tRRDv3iO
         CrjrcbNJ79XisPq6/z5S6yNfNQ+CgijBuApa8qFCzf+NSfOL5QID381hz99Ju4+DAQ68
         Zacx3UpAmfbQ++2JZxYq3EFqWF3/3ZNCLSRdGmfVRP3CtwQBWVTzGHC0D93mecQtxNVl
         /t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704847; x=1784309647;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrN4t+c3+bp30MOSjaFcq3FvbpeuOxTLajWgTQ/N4Hw=;
        b=GhHtxicwwjFOtDYTg3rsSxzCNA7gBvlV3yH3U3+oI8H7+gfJuXrhyYaUItIHdekQAW
         Yht8NR9xZirAhS4di0tioVZyrkPrJ6ltJN0nJRnpBR+tvQ6FYzyXiR/tQpsqEK3NYCdq
         MKag87xi2cHRHwBUk6oBf3c3doVOuVgbomeTOJx/M/agziBOzxyGf/q4TdLp/3kDcx75
         OUB5GdwTamhMP7OQ60zbm6N6mMWkwqleX6kINtIwM+heV+JOzulYI4x8NMQASFbkMmR9
         lngPY3+W2/Nmw4zp6CmZ0jzzOFfL8YALwBLHEhI1PjVFagUh5rNyjdcYCoIqDdb+KUtp
         Jbvw==
X-Forwarded-Encrypted: i=1; AHgh+Rq5HK0Co3zI/LWmg2BY6TlSEKe0AQGZ1uC48I40pvTnFBEKLN2Lq65No/JoOx9Sih13EMuWrn0+ejgnAhCI@vger.kernel.org
X-Gm-Message-State: AOJu0YwCnGZkMSxZaBPYk7ZB6mzjrOTevYIlZ/7jXh6MFUVFL9ul+Aqs
	+ThlqReU4oVbCb4CjH8CeVYnIrYeje2v7Od3f+jhLl9yAXCjmK+01JEB+uTDOm383gFbo+U0CiX
	t1Ug5wBT+16w+06QWAqQnkpSksFCFPeg=
X-Gm-Gg: AfdE7cmb0aKCfL8q0WL2BFenLPdEqrAF9pkIcUjhVnTcyAyjzgAbF4sZd3JKnrW1NGC
	s7b4P107cKaTEMS+ZQqRxys941YPf12xAX0chxX5NFfOA//3Ol/S3PXXLCnDFE88YBOKjiGg97A
	DNgQaTo6wpo1oz7S5f8wjDio+7GfH2eOydOc2vIldv3uBB7oHufhv3jJqCAYguahVIqTO1psyiD
	355SUTokKTPcL4bUSAf+U5vFt3NA5kYV/sl58dBWn3hfTYPY93Dl0V+qPyBotLBfFHFQtjb00S5
	mXpDgSHURn3F9wLl7yrzgwcl+IeUfSSWYV29l8iTXOawJLKelpzwGMnoOw02oeesfnEeVSDQfvi
	I/N1TKEGNDN09
X-Received: by 2002:a17:90b:2d0e:b0:368:b002:bdad with SMTP id
 98e67ed59e1d1-389421ac44dmr10172029a91.5.1783704846625; Fri, 10 Jul 2026
 10:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-modules-value-ref-v2-1-12ebbf0510c9@kernel.org>
 <52feb9b1-2073-4fcf-b2d1-a7f42f1e72a5@suse.com> <CANiq72m3w7L5CmAsFvOpSh_jNk4jL8+A4vz8GEp+E8FY=TJcRA@mail.gmail.com>
 <30e500ce-e9e6-43cc-bbdf-ded7c0ae56cd@suse.com> <alEBInX9gD1M5NAr@google.com>
 <bd1f78bc-51b4-44b7-8e3c-7accc9e173f2@suse.com> <CANiq72nxK=nCf7C-GQ8JCtaTnOaDGwGDFKoQEVb4fqNonkKn3w@mail.gmail.com>
In-Reply-To: <CANiq72nxK=nCf7C-GQ8JCtaTnOaDGwGDFKoQEVb4fqNonkKn3w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 10 Jul 2026 19:33:53 +0200
X-Gm-Features: AUfX_mxpYRAXpHh167qMfvyuyRIHpVHXCtc4SQ3JZqk7k3B7Nfp8isZoobBknGA
Message-ID: <CANiq72kpR9-7_WLzt1d4FrvMwwMAmvzuHexUXFE69zL4pi9o+A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: module_param: return value by copy from `value`
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 7:00=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> It looks like `panic_null_reference_constructed`, added the other day
> -- I will send the patch.

  https://lore.kernel.org/rust-for-linux/20260710173252.191781-1-ojeda@kern=
el.org/

Cheers,
Miguel
