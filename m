Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239513;
	b=B8E7fxvpwcZsXsNg3UAQk6XNBZpGS82VBvry/SW1t3a75rSb4fkz9F7sFY+4iz6o5flO
	 Bsz7ZI/5SthtKXbxLJdlC7qpCYD5uZ2a6u9QNS/MtVgEv0DYh1IZqbi99fiON6crEACKQ
	 jFmA0qW2Wf4Qm8JFx6/JO/ic0KmIbiKRyzjSsxBndu1hEF/OiIcVvwlMY9f9z8zkERWdV
	 WtDFVOkFx6JufOvsqhYv1DfWvBdc+TPe2DaePL0l6pR3oetmG3/w/OqpNdynhmwKK0DD/
	 B9j3VgbzaNyweqZvVMQZ0Y/YsKd4raV3Dkn1NeQT7ZFRova17J4WoaIcxl6OfCkHbkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239513;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Cc:References:
	 Content-Language:To:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
	b=ApFerg7OUfoFwGZ5WPnigxKXWIk9VIDhWfhfKPyzE73LL1vqGgnUX+N5iBY1Jo6BuU2I
	 g2lJR6GEXUutm+mm0DJE0/CBs6Mml21BiC8vrbxH5jYMzKPNd0+3OPMpPp6YXsHa9tPKh
	 KJvHtt5djLOPYjshvJ0fVKACFNHuoGid/XOtBa/UlKjXG07L1t/CErv5H1xZwm0Jhzv+v
	 JaLux1YF4cre1aa8dMCAX5+MbzWinbLbv9WijasHm1+22QamwyymIXPLDH4c4y56g0KjX
	 RnOr2qB0195BDBi1/YcxztXE1TyhdZcp51I6b1WAxUiWcb0pPj9gRfOjqmA7IBIelxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1097606A326
	for <linux-modules@vger.kernel.org>; Mon,  9 Nov 2026 15:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1097606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=I6Gf+TJ+
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e3b22e971so563441f8f.0
        for <linux-modules@vger.kernel.org>; Mon, 09 Nov 2026 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794239511; x=1794844311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=I6Gf+TJ+xx28C6M6wGa7IriJIxP64CATq5xKa5KY4/dVEF70L68u8oNbC3qDhkhEI7
         7ia14iP5TbkPq0pUWtgTMNnR57unFzAtVelBZ6VlJdQ4CrgVYgxw4RobiXpnUn7hkB+D
         nzTyACD0+MFjBaqWPAWXlFUgKFrj/LJmZ6fQQvFA0wYX9Z+YdDx7xP/wSzXM8J7jhI3Y
         cnv1opUi8bNDC5CGiUC5RyhE5sufSwg94ps4g0+w/MIT3GHEM+nHtCTD6yBD+zcjVMzC
         KM6SnUFC/LBhWAJoh5/3RAr1pEMN+dTTDdPPEWzL92kIaF0QNP3pX9QYFDhi6xIlcLq5
         xWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239511; x=1794844311;
        h=content-transfer-encoding:content-type:in-reply-to:from:to
         :content-language:references:cc:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GqcUVOE8YZm1FPDzDze4+rCKgn8rK0xiBVztztTok30=;
        b=pMktxf8oYcP9uuJ+6kqctP9t+lN4nmgTyeu4UWjiad3FYEtvXeZnZJRse2aFOsyqxD
         9q06cuVeu2Y4MBDrAqK2QV99eRGt9oDsgwD9dw94JDeUpxf67B953S0cnLVEULOSaPNS
         EcYCZpCmGyM/Isy6BORs0J15ZwiCiPbIzjRSWz6JxUCYplE9mOH3pLBU5gSwBwn+aETl
         fgE1Ul183sSYbsXteMu1LhQ77MvDGgTmGgCQ49ZQUrWaWmy3b1L5NWJInnSU5U9tqF9Z
         EJyEblK+Vn4iYg7TKyNXEX9ZNLYyHn8n8A07no0LxCUDh5Krn1x2onCzAoSb3xV5sxQP
         aawg==
X-Forwarded-Encrypted: i=1; AL+hErHYgcY1H6yi2lpnXyIwt5XJoJQghcPp3kGIV7KDS7APfE/mLfctU/lf8nCAIbBQhvhDPwW1ETH861gAyien@vger.kernel.org
X-Gm-Message-State: APuU4Z9F268ILXUkclSkPzgpU/sM0UyKuzuyjWiLxY0Hy5ASAPq8ayvF
	T8xSiW2MpXDtZtKSE+hNP+sEntLmZQLY1kMe5S2m3OldeK7+t1K4NCb0nQq1AmVsWVA=
X-Gm-Gg: AYBFou09W95p631mE+KACfB6bdGcyggXVz6LDk4wqwh/0/uwlpH3MVDFxiqYZTVg8bO
	czDvmwIGAKv1a3Q6Gop/qCmWrjvAfZA0hDTziB8I7mSGHWFzCDuhaEBok7uFz5l2M/f7TyF584O
	06CmVvD6/hwfmWs8CQjHm/dZZiQunHeKUGbZonYJCzP2Az5iOBINYMnBHnbn/8lnDWoViXAinKw
	H2wkb/Z2y5Vl3ApoqwBotAPgnXzftsiBmCc6YXu1PeB0yILjmXN/LmQQQou5Om0bhia1KAGjFRP
	IhKk9gVSOcI+U0n9XfVr80WGCxLXsk4uY1YrtJyyK22ZwA3ooqt2SwlPusU+N6zsOqntc4/KP08
	fULWZNHHaYQWeQpY5OibQb9nzJFA4ALDnZRAWTbfXDxgfOBHd4Egp2eXBYyUOMkkp2iAB9nIGCl
	vgVTXHiQtPRsWlP6EPhOm26iFCXyly4r2saYwh3yMrtpS6CMAINgxPjJes50ArXq9SInRXvaxsw
	5CeqrP3e5SroJPiT/C5GDugtvJ+Tyl+ZorH19W3SPQHl6VISxy+vc5pTCLEQvUwosvKyR5bmrLv
	L8yUsqIlnfZdOHD+BPH79kk0kUykiK3TpCySsk8yZrCfP6OdingpBYeh8AFcvMYF
X-Received: by 2002:a05:6000:25f5:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-49582e8e516mr8245452f8f.10.1794239511204;
        Mon, 09 Nov 2026 07:51:51 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597186eb9sm10435718f8f.35.2026.11.09.07.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 07:51:50 -0800 (PST)
Message-ID: <a190f981-d668-4208-8148-f4e50adb31a6@suse.com>
Date: Mon, 9 Nov 2026 16:51:48 +0100
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Remove obsolete __MODULE_STRING()
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rudolf Marek <r.marek@assembler.cz>, Andi Shyti <andi.shyti@kernel.org>,
 Chris Snook <chris.snook@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Language: en-US
To: Petr Pavlu <petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <2e88806e-57dd-47e0-a9ef-a8507d22aa3e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 11:36 AM, Petr Pavlu wrote:
> On 10/2/26 10:31 AM, Petr Pavlu wrote:
>> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
>> MODULE_PARM support for older modules" [1] in 2002-12. That change also
>> moved it to the graveyard section at the end of linux/module.h
>>
>> Replace the remaining uses of __MODULE_STRING() with __stringify() and
>> remove the macro.
>>
>> Apologies for the wide distribution. Acked-bys are appreciated.
>>
>> [1] https://git.kernel.org/tglx/history/c/136839a1b4
> 
> I've queued the second patch ("drivers: Replace __MODULE_STRING() with
> __stringify()") on modules-next for v7.4-rc1. Thanks for the Acked-byes
> and reviews.
> 
> The first patch ("hwmon: Replace __MODULE_STRING() with __stringify()")
> should go through the hwmon tree. Once these changes are in mainline,
> I plan to pick up the final patch ("module: Remove obsolete
> __MODULE_STRING()").

v7.4-rc1 no longer contains any __MODULE_STRING() calls, so I've queued
the final removal in patch 3 on modules-next for 7.5-rc1.

-- Petr
