Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1D480DC6
	for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126222; cv=pass; b=nO7G9LkqzFL4QkGQzr+TqJBQLTmrh2Q4KOB6WQgmVv64lwQf4tQ6gBoD/vQY8BYKApUjeZpgaanH/P/DmBxb5PTlggsq1KMlLL8RMgRf6JGQa0jsLDLFYqB7ZMZxixOWcVCDLiAxsaM31B2HHGrcB1zvRPreRcjGSn59y7r6FgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126222; c=relaxed/simple;
	bh=wPDcDHDQj8pmP+qzkh1hEraUCuRV024udnyWVSiSX/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enRfgqE3SvPrGmflGdcJSxWe3TbIkjhmlBYQhHi+2qro4SdIkvsD43/HqNRI15Xzej/E9SfXyKdXCONuQ8b/6iIPS79TRa/zrb/I0Pbqoag6XYlJlU7LUDuCjqEvV80wHN1O9iuymsuO97AVvXV5GeF/sOq2mdrRtciibcj7HEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4twG6tr; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4twG6tr"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2f6e6a0a215so122228eec.2
        for <linux-modules@vger.kernel.org>; Mon, 18 May 2026 10:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779126220; cv=none;
        d=google.com; s=arc-20240605;
        b=T9gRW7cuGiv0pUqqxQu7aDXNY0Qy/4brV0kwVpdV9XTUmQdXph725Tdrw8pMWFj8Fa
         Vom02hiLEnVAA7G71HJHjWS8GSsfAp+FwoGJtCLxMjF9MdqLcrcI7dlKZwRU7mSI6jbD
         ROeqGol+6P5ZBeelsqIAcK+xTddBYF4RBfdDr6MF/Df2m7uJpOxjidUuY3xvGy7CsiTo
         79XX8+3e7VSxLGMrnpmIQJWLPDXbXOT5nSq/S7FP9zzMjBoEsniShwGKfg4yh3LhPimX
         4KB01Acaed3C+8s8piKS/eD8pI9MuLf9RDbuxxHjdLo+dd4TO913/Qc3O+UYfvomaUKt
         39Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tdcKso0/BujWCa+dO/P9U397LpVQKNh1JdKWMY0FaqI=;
        fh=FKvFHaeIVALwVXLKkyBhCUhcu8Q3SdV5T2VkoHFtn+I=;
        b=YmWTbUTeC0aBi62jXHbhhFfMY0o0zIU83YT8jrabBVgzpRUyzdddXQAW92sYq6t2CD
         Cx+zJSINsubZ55FfnAdSgdUxRTa33Y77ylRCeDJFQ9M2hVYT7yXOiKUy1yFzbPN3mEXK
         JvPv9OpHSumc9WOLc2rmV4pl5g9b6Cb2ZXGbLhVeoT7nHSlsSWlnhUp1+K0hoFf9HLxN
         APFt1/PKfcpt3WnhqjCsMTOMYMziCysiVsk/0s73bXTOv8Wx8wu2iXPlOJgjGX4Mzk4Y
         qEuzBrCXRC0UNTvGGPnriQJz5VGGuT11dbhem5EVnvx4oNn22GIc++vXnHX/mn2ofA4j
         bn5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779126220; x=1779731020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdcKso0/BujWCa+dO/P9U397LpVQKNh1JdKWMY0FaqI=;
        b=U4twG6trErnSt0uRI/4A+YfOF8IzLszpuyLZ6vRDGYaXF+TsdOoY82hmvIzubxp3pu
         tgIPDdXLhELjz1rSHSO2i8akmPVU/BYdl2uMZP31HcyiJbQ2qq4uDKDyDB8MFaz06NOZ
         NecYC9K1vJdWvtoVeGjjfDY4RkDtNRyUlLldtXXKJSBDOSGAxniIXD8d4ueq3Jr6MNAC
         eIKgp1eGL+0/wnAqRQLtjvp2LFYY5U+syJxAjn97IBlL8wMALiNUy55yGLvjkJypqo+O
         MJuZjvJ7bw4BqlEURnpNY1ITq2R19s3ldLM0RXWiKlpOrMBKWU/EZf69nfQH05Yjbbqh
         lDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779126220; x=1779731020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tdcKso0/BujWCa+dO/P9U397LpVQKNh1JdKWMY0FaqI=;
        b=spFT9N6nhU1ziBnkGmfMJWXNIPIzyBchqZT9qjVN9QyZNZTpb8nJmpC+raUTedBdqK
         Kv+Aj5Fo43fhLigM5/PM475LKFoATtksfYKjcgX6xGDaMgQ9uyLkixAtI+lC2Au2901n
         jFVYpcIASRYag3TFEcWm+I3NvO8nt0fvhHDPFHmS4jdaATxZJ8kgW4mX8iR/z7DUBYLY
         GLEsATrSCSvx78KnTe4wqW1RGJMyfMCnFIDWSzBmj0tdYptSOtUlSsvA2kwqDK75ZDDG
         OG9FgB56r+9AddWzBzjAWrPYHMutxdK35M8fHzOo/NzRVKEqR3VT49s/RH2M8jyLIb+3
         gf+w==
X-Forwarded-Encrypted: i=1; AFNElJ/Tum0CSEGPSPahdHe2rCpETcpHvZCRFauJWE0xnrAB0yB6/ssxF/WBp09+kfCGyGWQgKgbE/bUmWLkgglA@vger.kernel.org
X-Gm-Message-State: AOJu0YyjL4Kk9Eux4l4Pw6dF4IPVDRBO4fqIHFKekJRUVlrHJ+2gnr92
	bR2PHVeirRh7nSKqSlwVaZPSRUK9WEZDsyAOzaZW0UDn9e3RNCXHA4ITS/0Niha0TlFBaQxyTaD
	s1KhJOQMEV+kYYkAVfNnWQN3Qp59R0qM=
X-Gm-Gg: Acq92OF0jN7n0+KqROPxZGnGNw8p2akHrA/QDz3mA5LMKCw1vslqzex0nrq3JaJKFnX
	Fg7WSv8Q6syNbFYDWMPF5K3sD+hZ1EU/iK0iVR5ZO6/F03b4N5DOiQnbMJ/E7MsNu5LvPSF7sle
	xTZXkiZJB22yhWbC1kGGtCef5IALihwWkyxlRJhxUkNIl0DCLgSz0Mx84ZyLPswO+2CKYGI38eI
	TakrEQdJfA7zi1nGhhiJB+w2v/ZdTGDB0/pu3aLDcoubGrjmV09UMDZzm3bWoiha3YjZJ//uVBl
	6WpD7WbTtQuXGhuS5y9fJxutCFlbCovqklNDijM+bo4Sz0ZNRcCb50C8QtJ5KcPl9y7CWYq0h8q
	afb3SKpLAH9f2yZLAIASPzx5ue0MdS9fIBg==
X-Received: by 2002:a05:7300:dc14:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-30397b88952mr3173578eec.0.1779126220480; Mon, 18 May 2026
 10:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
In-Reply-To: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 May 2026 19:43:28 +0200
X-Gm-Features: AVHnY4IvdZI3MjjwxNDAYmlgRoQbD_087MrwcFjSD37edYlRRX6tgZZOZcjVPUs
Message-ID: <CANiq72kgM+ugZsRda=xfd=So1UteKVh=tSBxZAq5ETwk2zUOwA@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer warning
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:13=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> Replace `pr_warn!` and the accompanying TODO with `pr_warn_once!`, now th=
at
> the macro is available.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This seems to be:

  https://lore.kernel.org/rust-for-linux/20260226120848.82891-3-adarshdas95=
0@gmail.com/

Another one was also sent a few moments ago:

  https://lore.kernel.org/rust-for-linux/20260518134107.4114-1-cppcoffee@gm=
ail.com/

Is modules going to pick the original one? Otherwise, I am happy to do so.

I guess we can assume the reviews here to apply there.

Thanks!

Cheers,
Miguel
