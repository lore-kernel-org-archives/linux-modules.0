Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57634FDE62
	for <linux-modules@vger.kernel.org>; Thu,  1 Oct 2026 13:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862062; cv=none; b=dG9Z1mkKF53AUNeQTSNvHe/rpmY20+111ncF6wW5NeuiSKqwaoNXHtWjG4tl6BalFPUzCliVRkq3pPOVZKIV+yRgGdsxLsU4wNd7zgJT0Bp2KEHifhjQ7tTl295L12ySKd+yFaffIQrGfyt0xhkMWlQ4DDv8nlO+X8rgtkSE3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862062; c=relaxed/simple;
	bh=jSF6sckf2CdykpIyTHyIXc502TuC2NL74BfAZtOKhK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0gACU/X/YHuR/Ei7ALZkaxYxSwGZdPIVq01Cpegz1V81pzhEUHeq3Yh1xpjJVcq0MyUJ/Of8rzRy3+UipPgYMnV6fWgD7JCwG1OQ6UU+9Jdv2iqddj/09epCOnJY5KBgAvEj1prZ+AiYAGmuDWie+E43F6AlVwdVeUqUI2fbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=exp965j+; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="exp965j+"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso3420672f8f.2
        for <linux-modules@vger.kernel.org>; Thu, 01 Oct 2026 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790862057; x=1791466857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGqLF1Rm/hEU75zgoHWcWsfF1Mh1p1AKwwc942QTcEk=;
        b=exp965j+dK9d3Gg6mjmXjj64N8SdLOy+ZO3GDm6KuE6rw9tKEECr6wmASJdpi7W+A/
         X1vof8aRgStYFZTE9Dnqt+0uSPx7g655K+vzr0LvkZF5qV67VZnkXVnnaYARmlEj75nX
         ljbntdkA8J3v/FpBR2KA1vB9xIisyPDceWiKFoNsmV7ugiEyRoKO9BazcrAMJaGIUPNu
         Y4XAR4SHh9QDwqol+bU2O030hn2Qk44gRWDi9lXA1T9cehmU8Pprdh1OOV2zb0YPUP4S
         HNUHFt/SgkuRX7/no6zQ+uvTatXpJ1rDOWX1+CDt24vc4a6p8pm/i+PlatQSEKTKPZlD
         d9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862057; x=1791466857;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hGqLF1Rm/hEU75zgoHWcWsfF1Mh1p1AKwwc942QTcEk=;
        b=LVDHx9tvio77qjk2pgv7FiXEq+i2Z0Un1w68oIyv/JOqHowqTgIEnDpHFn02MJMi80
         GKfip1UNJVoitfOPFTD5w4sVhIRIUZmmg+IDqZcPjzZSav+GVLc2b69MgiqaSYQHOBJd
         B2Wkqwl78nJLojFT8ckN4CfzUQRZTh8zernyzBMFaDhL/wX2D44W5V1aEHz7xcV8u1Z3
         v8vlmqlK5sRRcSl5y5h9YbuXYh4YYAv2HUObWouHo7UINcVI3RbtAFbZE3RPfOL+Gtvc
         PxueozbKg5BIFOb8ZVUm2X3X8YcEvhEcn6ax390124gj61BnUAm9iEgoZL9mV8gIrvMG
         7Eww==
X-Forwarded-Encrypted: i=1; AKwUvBzdrq5QHFs8WqsgVcfwiU/k+RWogbQQjSWy0qVXpwI+W+/CYEC/yerivXKhuQwVTXjg3ymW8ED/ojjPp41v@vger.kernel.org
X-Gm-Message-State: AFq9FYKGUh3g23RH1zIiLjERCz8WkbnsMH5PAm890mIkAabw4mf1XwJ6
	890PvLUjbtgBwvyJ3iWEDPVJ+/p4+HmKQUlc2VtcyfRZu7ujsI5yp8IIgONtkx9GqlY=
X-Gm-Gg: AYBFou3bpxWhgDJKqEmox7fMDGNVgrEhvY8P1UD9ZEo7Sbb51vh55kwRGLTqYCtccAh
	xI5b9IEPHZkIG1WzJK2BG1S8sk7Sy5Uq+yIADQWW+cyNTDxkB7Y7JySi9x1ircOitCi07QTn0v+
	9bsrvWRpJNElq7VhiZSRqJHij9xPGuzXhyDL9xSKX5MFyImijsgDXrQkKo3/bWqPxff/4pfhaCV
	OsW+IbDhbWajeDgqfP38Yqk/ekkM/jfB5dvOed8O7n6ILB6gWxJTqYoQ+yqQO2o58gBCgdSEpxd
	t4JPcvPaFd6S57K6GxeoZL3EZVQkO0I5akglxeYAf97lzvtT9LMpxNr0PMvNh2kuHPg/afksk92
	tfg4VSKjKZYPbPV5cS0G2eFUpUBJ7zK9L3tFfxafLTeWAgFF9eLg1kPLr6Gl5+w2fC477pDx0V/
	gj3OmOgM0aIlTtrSkF6hLhdusUqwtnlmHaXCnHq18JP7XhTXk36F9SdkCCm5CcfMcAt/0uTbRtm
	QkdS8ZH6p2KL5rHQkMsXmp2TiPQVjAY9zc=
X-Received: by 2002:a05:6000:3101:b0:48a:f318:ac03 with SMTP id ffacd0b85a97d-48b02505291mr8094664f8f.25.1790862057220;
        Thu, 01 Oct 2026 06:40:57 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0691d681sm5667084f8f.23.2026.10.01.06.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 06:40:56 -0700 (PDT)
Message-ID: <2ce83a44-c85f-4e3d-ba47-fa07a1663253@suse.com>
Date: Thu, 1 Oct 2026 15:40:56 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: macros: allow non-ASCII characters in `authors`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917051147.98775-1-tweek@google.com>
 <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <CANiq72nRLF7PmqqVUrAiw_M3dYZCr9ifoo+Q4SuXfBQsAFH-pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/26 2:13 PM, Miguel Ojeda wrote:
> On Thu, Sep 17, 2026 at 7:11 AM Thiébaud Weksteen <tweek@google.com> wrote:
>>
>> Module authors may have non-ASCII characters in their names. In C,
>> `MODULE_AUTHOR` allows arbitrary string literals which are emitted as
>> raw UTF-8 bytes into the `.modinfo` section, and multiple in-tree
>> modules use non-ASCII author names.
>>
>> Originally, the single `author` field permitted arbitrary string literals
>> including non-ASCII characters. When support for multiple authors was
>> introduced in commit 38559da6afb2 ("rust: module: introduce `authors`
>> key"), it reused the `expect_string_array` helper that had originally been
>> added for module aliases. Because that helper enforced an ASCII check,
>> `authors` inadvertently became restricted to ASCII-only string literals.
>> Later, when the macro parsing was rewritten to use `syn` in commit
>> c578ad703ae9 ("rust: macros: use `syn` to parse `module!` macro"), this
>> restriction was carried over by using AsciiLitStr in `authors` type.
>>
>> Change the element type of `authors` in `ModuleInfo` from `AsciiLitStr`
>> to `LitStr` so that UTF-8 author names are permitted.
>>
>> Fixes: 38559da6afb2 ("rust: module: introduce `authors` key")
>> Signed-off-by: Thiébaud Weksteen <tweek@google.com>
> 
> This looks good, thanks! We did discuss allowing non-ASCII long ago,
> so this wasn't intentional.
> 
> Petr & modules: I can pick this on up (an Acked-by would be nice!),
> unless you want to pick it.

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
