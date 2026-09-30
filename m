Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818304F68D7
	for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780120; cv=pass; b=BBhjyyKgTmk+1z75O++QR4e375op+MyPg6PN2zJ3tOKlSquNhePj+mkyNAkYea4LWiA3N0mn+D4uWOf6/JKhTw8Nc1f99DDCldBnpjPEqYffkDz1cPLY7jEDIMN6LUdy7l7EgpThTCnsfvYGpyN9h9h0eiSLXeltRI+62qg7pAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780120; c=relaxed/simple;
	bh=+9LhwFUxd3nuc3xpgPWp/vYsHWl/HfXCw8nLMlz0pek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtDb4NI6tU+rTAILFWo5nBVRZPXn6ThIJ2TjoOZ2h7UFBfzz18uYKIACnI7ToPsxEuvXmTdhKVsESaXiITaUNwxo3q/nX4GGR0m5Idp6bqhpNAIM7ZRPO0gpGdtSWG+c4VcWLbImX1cR27Ydnln8Y+x4qQOSJbnj+qzoriN2MvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfQ24We1; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfQ24We1"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14c96a4b7c7so171128c88.2
        for <linux-modules@vger.kernel.org>; Wed, 30 Sep 2026 07:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780109; cv=none;
        d=google.com; s=arc-20260327;
        b=H9EzfaU8KHqBrdiwuKyUnieAKN4La5rXdQEbGqPtkg8eqJnE/Q010yBljamb3af/Fh
         NwsFm0mMWmX1Um/C//jhRXV4KWz9vtl8pZj6hcMkpuDaah4Rw+Pc+LbyHTOFotEAuCDe
         PXBsVkMbzCgReIZu8UkKwGZt+XVC26GPKFe/B3mm6iNw9a0y1FaPTh7myPG3PzgREiFE
         TmpP2Jc+5BVL3zt6hFnr20Sja2Kj1tbfy5xLZDaoniKU/73jAirQ/JLiS+1D9hW00TUk
         Sg8hHZvXhwSLDcjFE2m3G4ijUn/bijcyecOaiQWZsCmLI3jju3n68NFO+ulJmF9f06Yy
         4Y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+9LhwFUxd3nuc3xpgPWp/vYsHWl/HfXCw8nLMlz0pek=;
        fh=79z1fFep4izRpDq6CQ6JJWPMugX+3uWzlYgsp7UTfVo=;
        b=ei71QS5PcVrUtJFCdQH1SeKVgEwIngKIH8jX1gAfVmEGKDI0cbuMpCVGWr1F/K6Y7m
         aHMOEEcpNaFg122hFdHlNheBT2/b1HgvCWIqATlwP75FFy4jVgg3Ip8fZw5gJESTPdls
         6HkL2700MjWnsz60LpkIYhbBNXLZhwMz+pe8/AphyYDE9hQrSrVZoGvNsYlsKf3/8JAJ
         npB+Y0egsb9SJ0rFO4MBlo32pV0FKwXmdnmsmyp99mQ3faJpvFdPAQOhwmzJtUT3EEon
         7jIKDsM1Q6Gom8ZrFtlJb+QLz0HYxWHWH2eaC16+h4C4kZQ100Gkj7AxnP3mFLud6exc
         xKZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780109; x=1791384909; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+9LhwFUxd3nuc3xpgPWp/vYsHWl/HfXCw8nLMlz0pek=;
        b=sfQ24We1pryQMJGE2pQ9MOBijyxeO43j/VwTvfKvkj02sGT788H95lfrGoEXB5q8yr
         ZiDM7DvYwvyGbcLlAz5b9QHZ1OuDntuIG9Yr7So3c5AB00/dAZI72x7lSOe/dC/nYRJ6
         Ax37J/bf2172HF1/cw7h0o7GtW9H+MCIVcyDjqMWXRkuWheqQ8pWEK0fLkzXfvVyjb6s
         3BBfTZIEPkRSy/TwswUnlUx6phPI7VABGsOs347BjNGlbTNWZL2KugASXZBAnuVRoVu6
         EVHOa/phNNCP3inMCYiFhDCMFtlQIUlnp0yZ0JwLusX87wOac7sJEpEFt+0fUOvCcB/4
         X7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780109; x=1791384909;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+9LhwFUxd3nuc3xpgPWp/vYsHWl/HfXCw8nLMlz0pek=;
        b=RiBCDywtpNQtBAsR56HZHzRklnmNPhlvLAW+nJ40w8mK8t3vW8/bOUNXqwMnp1hIPY
         LGusGXe4Lwn3DILZ8s8xx0bMRV0Tc/9Q8DS6gxBbgUZQhuZSYWRmYAFLHmQyYP3z/sf9
         2m7yAhr26FWk5GDfJUA3JVoVWuK1wiBPgdk/c/5OtIhYqRNCSFxjC4eVtaMrD6m34nV/
         SnPT9HGwQua2Z/sH1GVHDwh3lWYvFwor6Gkgh2Vj2ZixxcWaGRL8SWuf6PEjk+Heo2dC
         7pqiEFUhz4AE41n3tpE73bOyScJ9QtqCR9iEiWEqpL+2DdZsmlg9nctmvZhMQNe3lN7T
         mUdg==
X-Forwarded-Encrypted: i=1; AKwUvBwPb/iS+ap57tUAZepF5kEGEJfp9OSJIjF1XDGB6QfF7u2M3t6vt4KS1NljCkD1ygjANIKGnKmPpiAbBRO8@vger.kernel.org
X-Gm-Message-State: AFq9FYJew4CVJfeU2t+L0LaL/CvtX9//ygOwl6X/agUQZfKTv6D6gL1J
	5yJ6kiPMSpi65JFEMtDS0Lf/pG3Tibu6VzPYyx9VZ4G6bFGY9gTR537ftFx48L8EnrjWewSk22w
	hp1muMTaVzuYBi1Noy+mxzlSQdeOGL6g=
X-Gm-Gg: AYBFou35rAuvOj5jeGOwGWNxW5FnEMGrFFBD5SDxij55ONcz73EQEhfDpVtL7xEqiYs
	8geZSZy0vcZnTdhPIP9rYr1581nTwYF8IRlTPm71gGssJQJfXIb/Tu/gTSRy8vX5W8RMtYGBRLu
	nHmPDuUgWb/v5hUf/FBdJHTHfYBjc6E3Q7K3P3JcyyXcx2EliiZbl8n5pv0AbPFKQq54yUjjg5S
	vuZV4k20IDBZF5s/V4E5u2aqFPHCD8hwbbg9J/8eGLzskAvppMM4g55B+MLtyIWHPHFDnwBdJVb
	Sq6SIXWiWn2TdjcuP91zPSyCHn5gWoaaDeJRZxrnCwAvzKx5nsKs2umwWDiZgeNz1PxXG9E/dzZ
	FFTgn+Q/fR8iAFQLO8LW35J3kziBBubUAB/XFk/6uQlIbFHm/fWJw3DcF2gjn+5zJxM1fglW9vg
	m2276Mgn6ngUyzVgDDzaOdmHnq8nEY+csAujBo+Q5nxQkFAyJBcwY=
X-Received: by 2002:a05:7301:7309:b0:33e:6714:3945 with SMTP id
 5a478bee46e88-34cdeb6be9cmr3096391eec.2.1790780109257; Wed, 30 Sep 2026
 07:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917051147.98775-1-tweek@google.com> <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
 <DLSOH1EVCWKD.XEIME3CYEYYJ@garyguo.net>
In-Reply-To: <DLSOH1EVCWKD.XEIME3CYEYYJ@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 30 Sep 2026 16:54:55 +0200
X-Gm-Features: AclHuK8vs1MTQYyzGwnnDdzCftKWMmr3adWgFDGOHVj3p0ypcSu7KLDo5vXWnlg
Message-ID: <CANiq72m=rhBDJSSPBZ3yXb_r0jiCq7f8KOy+Fs1k8SzWJUwkhw@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: Gary Guo <gary@garyguo.net>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 3:16=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I'm not sure that this should be considered a fix. More like a feature.

Yeah, I had the same thought, but given we discussed the topic in the
past and we supported non-ASCII on purpose on commit b13c9880f909
("rust: macros: take string literals in `module!`"), I thought it
counted as such (that is why I mentioned it was unintentional in my
previous message).

Having said that, it has been quite a while, and it is also true that
for 6.18.y it may not be worth to change it since it does not apply
cleanly given the `syn` rewrite. It is easy, but requires creating a
next `expect_` helper.

Cheers,
Miguel
