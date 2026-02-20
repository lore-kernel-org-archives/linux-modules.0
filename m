Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC530E84A
	for <linux-modules@vger.kernel.org>; Fri, 20 Feb 2026 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574788; cv=pass; b=GhAkXnjOPE3t6+gBPf4mAKI9xJ4pYDpqmLwEICejcmTXiSNn7mo2Wfgra//bbFopM1RbOKLH/AW/yJC/dtU9yqzCXZNht4a+hGXsxRWebdIk+oCoxwn3RbZ1eBX/MhevrjobhH+kubsP9mZ3HeoJJBFcN9nERSh1DVM9HJknATs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574788; c=relaxed/simple;
	bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uy3CS8ZLz6boQUfCvsq4BPbMFIw1j/WdKarD8a21p+6Nm4SPT76HbWxOro1Lt+HFWYnjHBrbM+RPyM68HnpwlTgpZLdQeucks3A2h18TBm+hp/dZaoOcTCvMG/lHICHbXMuiLrlgR7Xf3VGO5mtH0O6mOARfdwBoAEcjjFpsZr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=pass smtp.mailfrom=chrisli.org; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisli.org
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ad79df972so1785926d50.1
        for <linux-modules@vger.kernel.org>; Fri, 20 Feb 2026 00:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771574786; cv=none;
        d=google.com; s=arc-20240605;
        b=gOTZKeglYn3Zi9u8EnlSUPEeJThAPEv8FW26TSiKydKyHXFGGbUlvPvxEKJf4mlqVq
         WnkDAhGpPDyyzr8AILu8IsbhPFtK62ykxF2bZI1U870bGYwqUuFl0JpvbNfdjjyKX87U
         rt8WXkKHdZxQnQxpP2a9o0JYzRz14Fk97TVKZztk9PrJ4Mm7yQORn71zR7z/qPCW+LPh
         qWoOn8etp4AzMeS3N20lMtVx1LIKjkvXqsDSU8gLWEoevcqrUFgUEKBSzdCfpvOjrdQW
         ZxOzWu6KiaKtH+EqtHiucLvJCFsn6kb0UmAvMEfyqcMidUzeEwrJaHyX/3jLiHYv4ZaH
         SeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
        fh=b2nOa3+n5yAGE1hQJj9EHHAi0vPv/uBg9UwYr3CEfIc=;
        b=FenlERfXjdibBYIqCIHmC56rz1bvnEMyymXRlTrc3s7FVcqwG72JiPDUifd1f36uyZ
         cDaxDm2Ta4GvchERXyn/AGL+UfA/xJLxcag9SeFEUKKXQ+nkKCUzkdLOCKGGzgq+uAvi
         ZAQC2iraLohFFePSEhXhJVO1EuzgeXZwn/cGaUs0NH+OqS6cWNhTUA7oE4FUv91V+nsN
         4f9DZbAyImMSK1D2yL9P+IlE3+APN7oq2Uy/njg86S31w7w5wKgQczd4lLgNtLpAZhZq
         Ni8ynwDnvkbu1Of4yjqqaalWIm5nLO/ql5DDMT4DzLOtDAA4wEj0YIlCJNiTVePUVYR1
         afIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771574786; x=1772179586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e5zleU7h447EebiFFaEjC8+LCeVuNH/6ua4IP1xwUL8=;
        b=iiCq3yBVWrXLPVYp8GPYo7jDWXPQNEgboEbTrTQOWS1YFIHyo69lP8zA7xjQZ+F1CB
         SkAlFJfJ6B0tub+VhFGLrtXvtcdRzppQkw80PoAA6SeU7CxA6/7UIja4URlqTplRJCot
         Jbrdac2yWejkw2Sm1Z1x6Dpa8kR6T+SDI2O2XnqMvXUum6zAbobFiqhv/sdnPc4NttNX
         pzPGhvhFh62fMqMn1J8E4Jt5S4Z/MjUs0ZFfX5dUS+pGYctJEFPpX5K3clqof5n0BkCg
         L7oLbn125AosvTlSU4Kg6S4luvHF7P+AjJyl9FGIaUKGsPs17STrwGB7mqdNBOkiiWcm
         AErw==
X-Forwarded-Encrypted: i=1; AJvYcCVuZBv6eVauloZg++tawJ1LC9RA/zuIftqDCGihMZB764fzpFciqPtCHNKvZN+ofhMwdLUCvdXLMjiLNNuQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/F8b1zVBxy8nzfCvm7gDWqvlbRAh7eHH4E2PM/bcq7zVA/czX
	4D/uk9fz9dJl13BruwvI3DZiv//U3GU6DJdcTu1LzJfWowz/PfCVwKLxpBjGDYQBWPNGReoUL+6
	NYzQLERLXHHqcuJVD9Ayz35MEy087jLh28LJhYo06u46Uvz89I6qX
X-Gm-Gg: AZuq6aK8INz4kWxs7BVYrijbLo1Q3u2WhQ60xTLXWT8PU0g4+9J4zB0jn52mxI5LBik
	WeP82BSKS5I4WmPDLjJqt/54Hpixdxjb7mO9opHazBpuf96IqwZCQU3Hw7a1YLa+S2Lvmw5641t
	j8N8y2j5vay/qi6BVtf4bTGnxDz1jjnzVh5+rnJ7/dcNZrCu2CS5J44B73trHS1TaGe5PIAoTNF
	R2HRTelwuDGUS+ltvkH/0iukBqiKjo0duAhlVyQKOR2At5MrOWpj4qy+8msUC0qYibAPo3HSpw1
	TjKfzobkodZz38ocByGvkFH0qbq6zE6/kfiYRAuq9qL5/dfT
X-Received: by 2002:a05:690e:4181:b0:64a:d6a2:c6a with SMTP id
 956f58d0204a3-64c21b8d6demr13929846d50.88.1771574786424; Fri, 20 Feb 2026
 00:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-fix-builtin-strlen-v1-1-3ec3efc0cda7@samsung.com>
 <CABCJKuf8jh_yxQcR1=uMeuWOueXyoM5=L-QpTuBenRi_MZK_Gg@mail.gmail.com>
 <aZdAxZR-c8PY_uEL@macos> <CACePvbU9Dh-caC59+L7wicZF+3sMjc4NC0HEkp9cVa7qqdydow@mail.gmail.com>
 <aZdighmTJN-JaijL@smile.fi.intel.com>
In-Reply-To: <aZdighmTJN-JaijL@smile.fi.intel.com>
From: Chris Li <sparse@chrisli.org>
Date: Fri, 20 Feb 2026 00:06:15 -0800
X-Gm-Features: AZwV_Qj4DeSt9QALEyytzXQrgOdJyGzDiyFU33t1N9UN_QnTfjz6H35KFosuU-U
Message-ID: <CACePvbWpC7o-Du=pr4Cfn-pM_XcOM1v+6cHb5mqaaEvzsvMX=Q@mail.gmail.com>
Subject: Re: [PATCH] builtin: mark __builtin_strlen() as integer constant expression
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Daniel Gomez <da.gomez@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Sami Tolvanen <samitolvanen@google.com>, linux-sparse@vger.kernel.org, 
	Aaron Tomlin <atomlin@atomlin.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	"Luck, Tony" <tony.luck@intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 11:20=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Feb 19, 2026 at 09:06:23AM -0800, Chris Li wrote:
> > On Thu, Feb 19, 2026 at 9:00=E2=80=AFAM Daniel Gomez <da.gomez@kernel.o=
rg> wrote:
> > >
> > > Can you please take a look? If Al patch is the correct approach, any
> > > chance you can send it and fix this?
> >
> > I am asking in another thread should I pull Al's git repo instead.
> > There are a few good commits there.
>
> Please, pull Al's work, My colleagues and I use his version of sparse for=
 a few
> weeks without noticing any downsides.

Thanks for the heads up. I just pulled Al's sparse repo.

Sorry for the delay.

Chris
