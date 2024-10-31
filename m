Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597019D899
	for <linux-modules@vger.kernel.org>; Thu, 31 Oct 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404844; cv=none; b=MPqdCuJUzHWP0Xx/MiibUCRSynIOyWBGUeGUKDadBQZoQZ/okZK/plWeBGcobZhm/bcGBrM2rcDIRlvzT4/nBac+7lSJHbtCwXZcWTMPNcqvOn/NNMN/TlObywq44lo0b33fab50VDpZaN2txHPS7vlVFsXRQDtL34LqZju8vJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404844; c=relaxed/simple;
	bh=iDAzPgn9vQQIclwk4KVakaDzMOUp56nE/SfuLH3hk08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8To0/gG5y1hkkPF+aSGn39X0+uJtNSxpuuJ+CXtK3NiCq6qQRj5JyXGCuMID7ed5Za//M/q/S7ODQgxnx9Lwxi+hCay7e+oMDFljKnYFZOPHoFFhT2rOT7dVLQpVRXPnDtZLcolSWVgDR6j8IgspRkQxMvFTNnr8KHzLUYN4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qmx5JRG/; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qmx5JRG/"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e681ba70so1172e87.1
        for <linux-modules@vger.kernel.org>; Thu, 31 Oct 2024 13:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404841; x=1731009641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jkl3TjMzcf3dryOCaAILRFpWIEyfiit3GjcJM3g5SKw=;
        b=Qmx5JRG/WvY08/igfKnIIa69WHbuc/1HW5WvS5i20r3Ai+ppafazCqQLnE8dxX3FV/
         I1QY/ye7Og5rWWfPTtdXqbccGBxEQvnAIAtzkeScYnWZVCNygPnvCJOWOUpUssjqO+5K
         J8IlybxA+IqOYd5c37tHWU3SA9S/jl3m9lCBrcJe1/sBRyWLLSqRMBuuTxT5mJdNZZni
         sYo1izj3l6ptsaTZYCuLpfUgDNZtKLGPa4ysJdfV5Yvc+mML/5RElZfFbvGazsTh5qD1
         E6+msdA1dxmRntK4BMjPS4x7RmgG+P/nlzQxMX0kWVcwLMeoVdnoCNY0AR4fsA6bEyaD
         i5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404841; x=1731009641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkl3TjMzcf3dryOCaAILRFpWIEyfiit3GjcJM3g5SKw=;
        b=kU/UB4uOiaygVlRi0R4Ix8A99ezOEl8o4xtFOe19wqyM66jmxWQ3imOjUDgWDnaXuZ
         CZXCV49mfnthG8GMWSYAfHfMMKBoZr2IMZl6VP2XeV8VxE4gvaGAYxvJ0dUSjRJKCzq2
         14lExoYBzj2OzIsyBlZtMrQS3pHYDwkXcjNHc8hE+/IfhLua0shNCWZMCExQc75NYtik
         1XlyK8m0fH6fAqN4+se8w3V9kJPeVq/UzmpYpll5p0HO/CMW7PNO5DAPpA8W0a62m4V3
         1Mbflv0WvYT+2yxq4c2dSbtYfxV+k+AxYe0lpF1uER6zWAMtCvYHbU67V6k3m4I/43d4
         Mifw==
X-Forwarded-Encrypted: i=1; AJvYcCWBKsA1ebgDW7ivqBBF/Z0QUqR4JuV+Qdxn/FKPsSgv8d6wJl9miS/u//c8si8BPVXo6nzp6mzf/NHDPeIu@vger.kernel.org
X-Gm-Message-State: AOJu0YygFMRlfHLFczYFWGbFXCRWDkD5WzXbixTWzfEEDfzJCilasddA
	N9qtrhEJXHY6RYOm574/0kp+JKugkcJDdep3y+QvqlnKDgBZtoK4z3l0hxpBh2+/POLtliGI4Ga
	X3eYGVD1y+iFteinLJxbvbkziHKwUSUwQXzlC
X-Gm-Gg: ASbGncuXVjKsjzvpMyMvflPqrWDUTligBLHvVJYg3UknzbUOtl6Fd+2BlNXUXp1Mwzu
	XIRm2/HzHprM1O5AMsZXNGIvHeN/39T7lBa04ZhiaBp46XE5aKGe/jaUGEbS3xw==
X-Google-Smtp-Source: AGHT+IEW2y5lzn/VGPepBdOsO+AzXleOvvzprjMKDOQXm2ENavWPeRp4bswreZ8MVte2QFNa89v1fS8lAyebQn8YFdc=
X-Received: by 2002:a05:6512:4024:b0:53b:5ae5:a9c8 with SMTP id
 2adb3069b0e04-53c7bb8e9f5mr385129e87.7.1730404840475; Thu, 31 Oct 2024
 13:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-extended-modversions-v8-0-93acdef62ce8@google.com>
 <20241030-extended-modversions-v8-2-93acdef62ce8@google.com> <ZyNr--iMz_6Fj4yq@bombadil.infradead.org>
In-Reply-To: <ZyNr--iMz_6Fj4yq@bombadil.infradead.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Thu, 31 Oct 2024 13:00:28 -0700
Message-ID: <CAGSQo00F07viDHQkwBS8_1-THxJHYwx9VkS=TXC5rz3i8zSZSw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] modpost: Produce extended MODVERSIONS information
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The question is, if only extended moversions are used, what new tooling
> requirements are there? Can you test using only extended modversions?
>
>   Luis

I'm not sure precisely what you're asking for. Do you want:
1. A kconfig that suppresses the emission of today's MODVERSIONS
format? This would be fairly easy to do, but I was leaving it enabled
for compatibility's sake, at least until extended modversions become
more common. This way existing `kmod` tools and kernels would continue
to be able to load new-style modules.
2. libkmod support for parsing the new format? I can do that fairly
easily too, but wanted the format actually decided on and accepted
before I started modifying things that read modversions.
3. Something else? Maybe I'm not understanding your comment?
