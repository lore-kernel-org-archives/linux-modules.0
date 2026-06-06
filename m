Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4282F0661
	for <linux-modules@vger.kernel.org>; Sat,  6 Jun 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776973; cv=pass; b=VW5nMRZthtFjfTqXb1zi7xI/CgyLntCVoEtDVQF+/C48qhmSICrLjFlnUGlSFmyMg9+MGkkYoYMpHqnGZC/svwKU2fM4aVuvRsZzdeOivhFU4PVOeuTdzER2EEmhKIzyYae6IGGsOdUoMbo4q0AO0sRqfhtjj8o6beZwgle9sEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776973; c=relaxed/simple;
	bh=t61VPhe54vxRkzTIv6KDtACiL92CW80uU73EbXW0JRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIysp9cQjAuN6q6RvJnKL1KGKAGLzvRSgrLmlmn0M188iv6HfDQwW0lzguh5+vulG4CSRT+GtUEa3vm0Soi6KBkqb99yfMEgC/NFxk7dJmlu8R5ltq7R2TglPNXwSEYk5RxR/kx9gU217kqmjiIzGfIexwb/6psWwKaCa3PTigw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfOJ6Zqp; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfOJ6Zqp"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304da3b4508so312498eec.2
        for <linux-modules@vger.kernel.org>; Sat, 06 Jun 2026 13:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780776972; cv=none;
        d=google.com; s=arc-20240605;
        b=PuwE4srzTPo1zpWER79VkWmPd3OIik9cX3YnZmQYDUp8mv2GyseFXdaUOtZzeNpMbw
         9mLv16HJKX3ntgWnta4CBtxGWmEqut/fbTJJPRci2kAuYtdpw2QFCGGeb3F3HpYEZLoy
         MUWDXkIVTKz2XqOUDOiMBJwQELCX5oUMXql0noErRqFEXO+H8t6yR3fsI+PMRIWkuQiE
         ERBPCZ27msiNz5PI1nZaf2sS0qFC/vqiVeBf2PfXE4HRWo8OdB9fateM0EcSisprYeVC
         7Tdx1ZT2ndc4NzMjpfgDfUCMSj21uxXi0xMW5M3gSOxYHvmjY2HGfbIBQIHnL3XKNcDq
         ZtKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UEOGwrHaiA8XO9EWRCyhroUJgb0I3D3G4N5dDLfn/FE=;
        fh=Hdwv4VkipjJ1IM+sr4ovmWfhhgE90Lm3+Mw5TtwWMpk=;
        b=J9iL5kR4hjWqmhzFF6bHTFI5tlzq4dLepFDY32nT67XpDFpt3tPS5ERtB+IjZS72O7
         cFhhwyk3D7WkixhVJsyJ17xQe3aMurQSF3mhxU7CrR0b08HjyDzLe/PdFplvjzqvqTXj
         MF33Fg2+Tf2sifeoMJfbv5ECc0YfgHECGuM5v3IXUxRxVkllVT29owA4WhYsNWDNq/SQ
         pxh3ziDzKxvk23SXn2vuUb116BzWaO9Jcn2C/Uo0K7J42IIGfz9O0rOmYq3mQ0dqz6sy
         6mnX5NRZ+lPrFFVju95wBP3CriR5NBEGmpInQqkHqz3jhlLI1XcoDQsTUHPLa/6AUR0o
         Y9tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780776972; x=1781381772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEOGwrHaiA8XO9EWRCyhroUJgb0I3D3G4N5dDLfn/FE=;
        b=KfOJ6ZqpEQRxAWSqoj2I2TuWlBQeGpJiNbyzv/Xu4SV35Yw0fXCEqHToMtKWTavqy/
         +vAw3QNf4a3/9ms9E2tYiZb9HsaMyN3D8e/ku+oWRvKodT9l1kE6myjzy5PTKXN473lZ
         Kjc+bpyMWPBmVrBMaxXChd+oE01XSPM3q9IHuWi4MEPB50wHXSwpWKhh1cxNaS8J0wka
         oxiDMkJ4oYilfFqZZqFkXJsh7VwsuTHpSXjkEFvLxH1AZtq48BpOVmGzGvWmagZVjF7g
         LWdK0gppWJjhOF+c8gfIYK9AAcrp1/u5ZSpQ1/zU2njN+AFxkE2FRN+OMh3dM9A3WUHj
         2iaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780776972; x=1781381772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UEOGwrHaiA8XO9EWRCyhroUJgb0I3D3G4N5dDLfn/FE=;
        b=X59tTv6iKZ0Ee6GVTNDFcyOhYXVn/p9qflrT9CevUyM84fh7Bi5oLFF+qTYfJ7464V
         KYN0+tq+EYTb7eF3zbAQOUsmec+P4aX4R7f867NlYnmj8WSPGZC7ASYEL8yHqY47ibfR
         z+tOViK/p2HN+AGvICvR1ijDNpzdh32MzwfsXFdw3NUhQ5XRIh/BsyQRZG/I4jrjM89q
         HA6Jn8G4UbLLNnlzOeStwIMOGGln1vfWmHEZ2BvKn6YDVdgitpI1vBj+O166zBqVAvQr
         RBHCyBztx3dl+06n/OgJ0QD0LJ3LpEzcUib9qv6UzBKMEP91fTKOu9J7Qt9/xtZhtsG0
         fBNw==
X-Forwarded-Encrypted: i=1; AFNElJ+U7ulVvlsfriOYsJ3uwYKwOQbg2ga/JsOQzs+Ky6+xiMsA8KS9ykJb4yOsSJZFM9NeboPNTtSlCatr87Zz@vger.kernel.org
X-Gm-Message-State: AOJu0YxG1Iazmr0qJR5+NrZgQvFjN2EiadAzPjFqT+xO7Dh10QrblGLs
	t/6lda4KUTAWXbJrBj7349JJENWiFMpUIlR0o6IQ9dtloHs5OpFl3WbowDQn6MZaIOaJ0a9Y/h8
	s2RIV/wO/BtdwUk/6+IUSgoOVz2roRf815xW3D2E=
X-Gm-Gg: Acq92OEb9RT1NuJO12Fd3V2980YW0PrwJpFAqxjJhxO9QqK+6q8rMILVo5oqMjDwmN6
	S9WbJBHb6gcO8Z+yAVe4Ar4Fg74OGmuXJTlqCKi1+NlS6ENXuwVLThj99lPTh4dnnu/Kl7x6R+5
	cDKS7L0yzU4oXsafNrWXZ2oKE/CHWMc/e/sBu1VNPztnD+Or4COjJ8Ow3PVv16+qzbhIjBoOHO+
	oH4vpR1ea4TlyrQx9K69olqh1XsS6nszTvSPoFN9mZSqV5OTxJPA6OAE2y8QQ7OornXTGCXM2lA
	gwYxwqUkYPah/Y9whse79aD2JGyd79OlVbY0MBo+OhtcDwhnEcdosmplqs4lYXIdNLOmqR/CJlU
	E6zWJFDnIy9HwZRS4/0HASdTAFKFoGpd3UAu8zhYm+C1t
X-Received: by 2002:a05:7300:80c9:b0:2d8:7302:d3c with SMTP id
 5a478bee46e88-3077b36698fmr2188162eec.4.1780776971518; Sat, 06 Jun 2026
 13:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606-module-param-pr-warn-once-v1-1-96d9a93e8a1b@mailbox.org>
In-Reply-To: <20260606-module-param-pr-warn-once-v1-1-96d9a93e8a1b@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 6 Jun 2026 22:15:58 +0200
X-Gm-Features: AVVi8Cc7xJ_6E2gDHl_P8gKFX_BS_1RlVachhx79hu6aFhyQXTPndztXfotIn84
Message-ID: <CANiq72mHYTPBLHYngZTSbN1HppvGSCp+gpXg4FrM6box=sWjQw@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: use pr_warn_once! for null pointer warning
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 8:24=E2=80=AFPM Maurice Hieronymus <mhi@mailbox.org>=
 wrote:
>
> This resolves the existing TODO that asked for pr_warn_once! once
> it became available.
>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Thanks for the patch!

This was already sent and applied, please see commit:

  ac2f40107cf1 ("rust: module_param: use `pr_warn_once!` for null
pointer warning")

in linux-next.

Cheers,
Miguel
