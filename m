Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA053B6345
	for <linux-modules@vger.kernel.org>; Wed, 27 May 2026 22:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922695; cv=none; b=TJRhSzuC83f2x9noIursUg0s9/TFsOIQOJYUNPrRNvk8jjPt6DPzGteBh8uSIqNJIzxQBhI+jDD6VoLSYuYgePtPTNXX17TMMshVIeladCpHtKNBpZHlCwRTC/cNF0PW7k0hEuimKXuPgKRDWOn0Zg9x0eSFkgbmqiHZCkHdooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922695; c=relaxed/simple;
	bh=WsEkreIK3kaSY+Yks4fFmxDnN0WZRcmq6pLvjHV66TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atmjd5CUZ/U7I+nDmEEPyGlUZMd4ulG2ijoY5vFK9PKKP8isW4Z0mQ2f550NhSZQDORblSf4ySZRxR3CicVROIvKBKCScGXvtiJnw8k4t9ThCEBiIbC1B1+o1fwf6jPS168qm+fzMyQBzk5X0sYCXHsxvweEqI8+FF3eF0KfrbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbAWvX0w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbAWvX0w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so655ad.0
        for <linux-modules@vger.kernel.org>; Wed, 27 May 2026 15:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779922694; x=1780527494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ci2hLuxtqyG7acCyeI0Q2f/lfW0f79C74La8N7nlA1U=;
        b=gbAWvX0wz0krjFMqqoTJZUw/yeamSD3H8GQFafbYEU4MUyjor1+19NujLNkFUGM9ea
         bbHHI+cJAe6gtC5eIbh76vgu1uS4S1jwcvbwRsJNkJDpiyp+fqJsfnxdSlIekqslkdsz
         yRueoyRLvCUCEHGBy5O6ohgqmGP79bowFvCu8wRIykqocErPu3Ptd352B+pgHayi5yW9
         nLi4Vj6GptHfZLQj1BgpXink03UwI2Erolx5YGdPwETe7uXzNU3D1ZBx6mxOgB2qmyuf
         jFQ5G8YjnQPV/aWx/NsLirBkGCSiCZeNtR9prmKFfsuj2xHRyiHiM+2UA6/Qn+Muo2Hr
         1ywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779922694; x=1780527494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ci2hLuxtqyG7acCyeI0Q2f/lfW0f79C74La8N7nlA1U=;
        b=o+PDKz2lWDLKP8IFUBNfbzQ+O9TqUiX+Ic8KOHW82pi1rUmri/xmw3Lw9SJpx1s6nc
         WJqm/aZKhHrg07yEkkdNF6HnUG1bF1ZiO1/5X4DUHfPJ5bUaukWiLEUEQfrpGMdVGkd8
         RNoiu6s1yqJqechaY/OzSEE8IIt9ANfkMgsPI6RTmxV+mgl6OVgQQP0YLVQO1HOmfQZ1
         7FDSUe++ZBa3JKs/Y+pK2/sL+9WQHp/lg+lw3EvLCE79b0xbeiO7fp+2tExyFpHoYmGy
         tBMrrSEVYpGMpcS5Ghr1ExWQiULoSS8XJXQDNdG0Y9vubqyZSFvToZWXs7MJiAah8qS0
         4fdw==
X-Gm-Message-State: AOJu0Yzf8AyC2j1bTZlPpQmkW4+F+V5JixTbifEs65eNJYstnFAyAvBg
	nN1/Q6rIFBMYaft9MU1aiGJSuZTXj4KCoVMoGFo2xwJ+L/3QW87gKolAeMkBu/birg==
X-Gm-Gg: Acq92OHlhIMmp1WBMUZJvAGIPxwt0u9cik+0V20X0lpn1hm1VBijYPf2ep2tlclfqUv
	/5dUhKqVYe5OGsYf7R0qjbSNZ54ZoPDGaalBUC6gOLdxm4ArWRVaQ/grsmkyA9bdfbjGRGAOYRP
	Nzl8nNvTcl7lAA/cfqaw5IzrRv/Tv+hQoXMZU77jpr57ApX6298Y3/gM9lHbek5cg1aBBsv6ZsZ
	xC3e0i3d7aI63sYAcK1uxlrsDplf0GAg98DeIOlZzQ9xh55tcV8zBUXDkdmFnq/IYdtX5ddSYqV
	Bh7FOeHCNGp5tKF8LW2axaFW6gPm0F0NFxRidvyuZeskbmKyILts0Fia+DkQe1tXnpqi6qg2qYy
	nDMGaUOchYKJkMIQRkRMHXR8tpD78E40x9/OfG7wi1OUYqeFCyMZAbtNSe12W3xgmKGCei4R1/P
	VFOMPwRq6IoCJSjs/NtCE2JliQMcvXaYvLcwfYTdatS/kvpsw6Wj0AOx/vplRiZl9evVEfPDh4j
	ZFWbA==
X-Received: by 2002:a17:902:f60c:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2bf03f0811bmr728115ad.16.1779922693181;
        Wed, 27 May 2026 15:58:13 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c7baasm20666645a91.9.2026.05.27.15.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:58:12 -0700 (PDT)
Date: Wed, 27 May 2026 22:58:07 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Afi0 <capyenglishlite@gmail.com>
Cc: linux-modules@vger.kernel.org, chleroy@kernel.org, mcgrof@kernel.org,
	dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
Message-ID: <20260527225807.GA655711@google.com>
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <20260519212328.GA2614626@google.com>
 <CAEABq7f3agKZqrBiu+UwXHY44mTcK360ryg-i0w=wEc_Lv+T0A@mail.gmail.com>
 <CABCJKuej82rrQbQ0eoG+JsY6Fwi0SdVJqduvps7eiPrJ_BgT0A@mail.gmail.com>
 <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEABq7e5NT0c58gG=fqFK-RmfrgUDA-8jXnmMMQZHMNu4hea5Q@mail.gmail.com>

On Wed, May 20, 2026 at 04:05:11PM +0000, Afi0 wrote:
>   Thanks for the correction. Updated commit message

Please follow submitting-patches instructions next time. I used
the v3 commit message and changed the Fixes tag hash to point to
the correct commit.

Applied to modules-next, thanks!

[1/1] module: decompress: check return value of module_extend_max_pages()
      commit: 3537d8d21112c2fc664cc09895bbef01fa64d34f

Best regards,

	Sami
