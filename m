Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F487405840
	for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779839198; cv=pass; b=i3T/bayXwQm2AXcimUlo6BPSN11rCAmC/9XPCbmOmpU3rDdtPGsoVJKiIVe3jhAWcOHF02GEqhASSyR6euAQ4Jb3w5cVTvzCGjI82912QDN0+tMUAy501G/+If2Ud+vvmcbQUGpSB/Jpu0gMyaWCPo3t8IYtuSDJWH2MgpgyOxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779839198; c=relaxed/simple;
	bh=OE40IPjMQsoQs3WEM7wwQ8V7e3xT0VCxjaueFZcZ2XQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q3NI1WmoptgS9u1SQzu4FTxi5cQXpRTMZaQ952r5s/uhwQ/or8b0PI/8EleW/tsI7eWV65Zg6j9dXcAaee9roFdGi9OGdydsZ3F4rPbfB1GNeuE36LPj0vX03K3m7NW4ha6qXIht92nIflV7i4oKDJ0Yu7v53kTKm5WnYVu0hWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=runIZYG0; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="runIZYG0"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3047a628b34so260334eec.3
        for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 16:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779839194; cv=none;
        d=google.com; s=arc-20240605;
        b=TnzquDLMiihp/784FGFPVKc6N/xqBdLWffocXzQRsar0kfBLk0r2w8IwNXYZRbjh67
         /YFYmfaG6So1Y/AjBqQCu4mFjpvTMmgMVLxFPnGma+NHF33fJmhWTjC1SXlEtNsoOpCm
         ABs1odICgKI7AQM1vZo4nFNLPSEqdLQX8iY58yvR6AAaa0SW5c2VGLlYygFl6hsOh95B
         qmXDg1RrA45gr71QQYFpTwC31Ce2WKboCKVIKoNKgFMN72ZNF97rWbRaDc5gjrLpGfVy
         4acdS892cjuQJnS87QCN31eAGg3hLlLzjOBpSmQA9jPktpOvd6ND+4MrED2/U+bziHtm
         +ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ac/Zo2oVKowYsP9ZWEDyaxuGIJH7vNJtlE5hWTeaZm0=;
        fh=K06EYLlgqJpGF6j8PY0USxAyV70H3qJ+W9AjGJQNpVI=;
        b=ffcmKZ6yNKNP78ECXHLMZ2uRwQKBWYa+a3W8lD0IA10URVlI/8vhyNrizR6SdlBquJ
         +UbqqlLQTet5NMsik+joiUzZmDLbEG6kymJ6oOpkvcU66ahr/KxudIh5fAEIjUZxwyAr
         DxNGYKATnzxUfUG3a9mGpxJvDPARMXH6i6bVN8I+/fkiQPzdxLApV9OPVx85zrHQYwmL
         E4nvxegk6K/5jlIctFCikolet9mCuG3YkcGge1EWu9m0VWnhnIFut3+N3rAPJv4cA8Kn
         EPbArFYHygvsq8cfPaxwxjcaIlbvvYn31OVp5oCMC7yJnVUUzjasvIdlSD2ZUd+2etNe
         mj9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779839194; x=1780443994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac/Zo2oVKowYsP9ZWEDyaxuGIJH7vNJtlE5hWTeaZm0=;
        b=runIZYG0YV4KKPD6szLxQ/Ia0lfYAhBqP+vrbtL5lffQ2Nqhb5jNohEnLOxpGyCs9x
         91U8XXM2UeqIwGy1+/KEX/iDdJEo9KK5IkB/Hj4ZNA0PBMJxNt/4p2MscPJiZMBQo5hp
         3td4x6PCHr9RbRUzFQTA5yVQBMgbCvWVeJx60EjmRZ6ydMaKUoxp8nS2ZOFq6jaVzSzS
         m/DCNMQELaINER02NnjjdGgboKIaZiurNImfgxkZsetAAYbIry0z/4+Q0l9IjbTgihQx
         fcAMbYuAzuFzh3JxgcVgLQ+fQeXFblTycDdFE3325j/kOi+T4A+8IWOCT2BPrYbBhtBp
         WvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779839194; x=1780443994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ac/Zo2oVKowYsP9ZWEDyaxuGIJH7vNJtlE5hWTeaZm0=;
        b=rrkJuvq244TubpYcBLzLnZqYU2ZZY3XvZBeDL5TPQjxGEJYs+2RueJWPNwHJbeGXIO
         WmHL5DiL7ZLIHOY4Isl1//YSL7M6pWwIeSukteXVD+sWv8c/FgmWSuVdmhADjyHDt9w/
         pKpoKfl9axd8MSNHAfgGbB1YdTb54QpVsSy/O6XVo1t7Z2dhb0BtzcqS3WjSheq19tFO
         h2w9XoGrdcVsibLFd1d60V13MWCzkCoH/xgAjTEmXJNZRfL4rbqZAPeuDbmmiFTl2UFw
         a11YWh8UZShoOhPOpxXfs21lTN/mfNagxgwk6ugURGU/HyQ2cKU3LW3Tb6OJQ/U5PtV/
         X/nA==
X-Forwarded-Encrypted: i=1; AFNElJ9QpqQx2JO9VVqcdMlWdOIpHkn4eArYQzuz3HzBkO1bUjmwz/BMGFhlYu0UlCZnQyU21W7ctqeQFJsrQ4Tn@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEpSlM6ngsSoCQLq/F/UyOmKQAJeSrTs2lqEu+ebATIGk6rO1
	v3F+KR7QwNw+vDe4SgeCQgsotO39OAl49E7PEJYDD83t9fEquqenwTFxm8QSZNKRT1D39/8hCHa
	9jwiII0P4xvWHA7A+qVTPOfKwbOds1tE=
X-Gm-Gg: Acq92OGV8r9Zy6zGXQEU4a4cXV9CXZac4rgr7/MkySvsLRvVP7rg+peeZEmyqu4hhjz
	D/tHSdvQoHSi3a2Y6aHNsWjqC13FfpI+Tjm3rtkRyEIwcqD4wbk3hZIWp/3+66bruVb0aoFNFPA
	oG1Iv+Xx88VYzNJmPplOhnfJx38+g3oYtf2A1DRWg8O9Stb+QpCmYUpKtz6e7JBInjbbRB3CkqP
	0dZ8z1tANwsV9ifuMnm7a2zLpktfg4jnuQGPYMt0Vt5b6Jxouz8+2bwfzhIIbuXuTcv7GAgU5vg
	cZeFYlwod/fvLtfpqIN89GcYsyVelaeIpJvK3X50X8zKb4yzZ3IO/SN0n4J7TLtMMeYwCFS34pU
	60tGMuV9nwA5wTBksOOdBmMY=
X-Received: by 2002:a05:7301:3902:b0:304:5074:83b1 with SMTP id
 5a478bee46e88-3045074b479mr2887048eec.6.1779839194265; Tue, 26 May 2026
 16:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-params-pr-once-v1-1-3a8c64704cc4@kernel.org> <177983883957.35274.15506019019254966722.b4-ty@google.com>
In-Reply-To: <177983883957.35274.15506019019254966722.b4-ty@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 27 May 2026 01:46:20 +0200
X-Gm-Features: AVHnY4JyDe6kZxonjTblq-aMjW2hkQeVHUhlOSNGuJ6949P6uWExcCT8k_RSFI4
Message-ID: <CANiq72nq45d+kvyR8jp-hdJhFHv-zw2i51mPCduBeUdgSwMKsA@mail.gmail.com>
Subject: Re: [PATCH] rust: module_param: use `pr_warn_once!` for null pointer warning
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 1:40=E2=80=AFAM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> Applied to modules-next, thanks!
>
> [1/1] rust: module_param: use `pr_warn_once!` for null pointer warning
>       commit: 8d2a562b7efe98fdea57d10caaced911fca46a3f

Even if we pick this one, should we credit Adarsh Das?

  https://lore.kernel.org/rust-for-linux/20260226120848.82891-3-adarshdas95=
0@gmail.com/

Or did Andreas send it earlier than that?

Cheers,
Miguel
