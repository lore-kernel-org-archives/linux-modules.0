Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400734B1A1
	for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520796; cv=pass; b=P8aO+iY7ngJ7hBo4HQYt9XorjKH8LXWTtV5kKff1P5oijmKrB+tnMH/9Fkyzs+MOPfJrf2aMaH0BANF1i8MwO3azIVe/liSl2Gu6EZA97spTx55qMaqfx0o9cgAMNibZ6MQXkBGOsq6Xd2yRGRGvbBO4nQVjTgD4GPV3BcWL3A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520796; c=relaxed/simple;
	bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rs+8SpEu8SBDsL9u4G0PaW3vkodCdoMxTBMz4q/KGLtFWG7X3nh68MTY6SA2qmDb++Lht7tAkWr9MgWhGhlYUFsnikkCUo5ewsgRlY7Q4eizYOhpnxfFSkiE8utXM5JWI97KFOHoxqTsvPQlJOlEKknGZhjH7Y0i5Z8iIrzUyBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64937edbc9eso1122543d50.2
        for <linux-modules@vger.kernel.org>; Thu, 19 Feb 2026 09:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771520795; cv=none;
        d=google.com; s=arc-20240605;
        b=biUjdPH2/Yv/vg6JqZ/DmXAq5MbD5X25pmk3oeGpXEtvM77ixNHXwXwV8ZauAvaZSI
         fVEVgpRj0fY74v2pvCR4MtCuF1kGiN2YJruvddNRsEIIB5BgeLLdksfzebRkG9yuOAyD
         k6yLpzT2sloEu/zn+tJw6pULW2tR3WX6KKJWJH3Et8BnLROS6jimwgf1VP8hk78Ia5AF
         W4ePHVsU1xKuPph76YdrPnpryBfYLVMO+R0IQqcyPNy19il3MTyBXPDhPhSMXRzciDLk
         gHIU/Rmb6lCRUL7ve+9AY8a0lp1xsRS4CO0uqIngR3Yd3tYucxd3lp+ZJQNrNsAaIk3N
         zbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
        fh=O70+q1tXWzBqm7n4GKIABBl341FzoGO8waNWfNI0LWw=;
        b=MbsskZ9yPApXPtCeo2Dq280lVsJrS/nH9C4qpiv5wx92VR6MjhScurCYJxL5793/Oq
         5UZG5Rze/8ML766+WyZSzjV43eKHnNfInOlReTSqrOO9TAvpGGamBhtz88Axhaz02SdM
         7vJYLt+mVnJfUeF6bQD6RKPKXYjEXL1oOOVfFTCw9D4RSiAIJPcja0YvV5oBa81cPpRB
         z7XYwlQlwUS8f9PbrAbLIHkn2fID6CMNWNwosUZfBjnAC5+PQh+RC7uXyGQk9ncQ4+kB
         6itSUiJZQQebw7n2mRy7bUL7TWCRFx8ztMjsq2JLwZ1OCbMvn0KS9VysJSaptcO0kvzh
         lcWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771520795; x=1772125595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PDL3ADfTUjQJ9baIpgOVXBhOINqlaJdo+eD/uky5pRg=;
        b=lHq787NqULRvx3xJTznaWKHqNJ1G/LJvEs2T/4HbT0cv78o9Kuh6K3BmfnYB99tR57
         IVP300lKlvOrcE2xH4Yofy/4dNkf38J+SY4DCCA2+tFDWCT3alK2vrGZKSHD/OoXrSvz
         s8AQzmmKdCU18EtNDrt4pwwz7++vaHO72B3X7I5oSpp8oQToXCoFOZ/9hIIFGWBpSuTr
         q30XHDRP2yNAa3G7wtWzluG8kY/l36sfZ5BDNdOIC2k84mvcEesFHL0UjkKGHw8V006G
         +a+zVoZsq+wCMLpCMSz49SffQLUaMzv2H5U9mglq8h86h3WJ0gbXWedvfsmQNkvUTvAV
         YP1A==
X-Forwarded-Encrypted: i=1; AJvYcCWuxNJS6HfJfBvcvJqn8t61fGqJ+1T9epBeHg9X6LIuBnagQvvxjh3KmVQg09iLF2Wm4nF1vxAXttXc9lxM@vger.kernel.org
X-Gm-Message-State: AOJu0YyALQ1GAkXDFpzg7cWSsJfMekMjOiQ9s6yUT3qNXEMjbWBf0JY8
	4vCUnoO6sjArHg+mpKtugnYj0sPjNpZ9d9IyRM4Uw+JxHNahYqlIynBLShjUWNLDY5l0Ao0hP7l
	z+m3mANDmDqp9nZwo/2TPjUpXYSjiSDLW2/FNkIvmkA==
X-Gm-Gg: AZuq6aLSLuPGH5xnJIBo5KJFawiDF/dloYMJHhnDjkKmyGuQ3xjpr3igqbfP/OosBZI
	3jNTUXi/lHeTxN3Gxvy2NC5Yh9cv24KjNLsovROeqCtavp/ENypQJQyKLyo4FLqzyteSJJ1cR3c
	vW1uYeZNKiarnn4X1z8B/LMKjRX7RPWwM7EKhf7aSQm8MfKjJf1oVNtVKr3f8JfqCNglxgkDwDp
	bpdJT8MbgWF5A4Xgx4pajZwrZLRAe62/IL1Byml2RpTRnB0VOkn+qeOUpham32gY8K3iRlx2gG+
	6F4yUgL1Nhj9GKZmadJeBWF7wq20+qMNyIcnFg==
X-Received: by 2002:a53:ac93:0:b0:64a:e3d7:58ac with SMTP id
 956f58d0204a3-64c21a442e4mr13833516d50.9.1771520794582; Thu, 19 Feb 2026
 09:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com> <aZdAxZR-c8PY_uEL@macos>
In-Reply-To: <aZdAxZR-c8PY_uEL@macos>
From: Chris Li <sparse@chrisli.org>
Date: Thu, 19 Feb 2026 09:06:23 -0800
X-Gm-Features: AZwV_QjdOnMgiLE4kypKeprfnuFYZTeLS_e2Pq8-K0baZPp_KSQ2fANM0QCJBe8
Message-ID: <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Sami Tolvanen <samitolvanen@google.com>, 
	linux-sparse@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	"Luck, Tony" <tony.luck@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 9:00=E2=80=AFAM Daniel Gomez <da.gomez@kernel.org> =
wrote:
>
> Chris, Al,
>
> Can you please take a look? If Al patch is the correct approach, any
> chance you can send it and fix this?

I am asking in another thread should I pull Al's git repo instead.
There are a few good commits there.

Chris
