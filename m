Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD4411F98
	for <linux-modules@vger.kernel.org>; Mon, 27 Jul 2026 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785164298; cv=none; b=cBrK4c6I7B8iX7Z7ksrCphW2lyDq4Vpi6jW3EFuH62fC+8QfnABhv7NfSNjAU6WO7NTO20hsgXF24GQLSL2Hx17tRjtDr7lZew8Jm3pMbUVC4Zp/OiEwUqhHUGtesUbjRaWpq/M+zW+DZWHy9Z58PF2LSSkigXw+rxQSyoMC0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785164298; c=relaxed/simple;
	bh=/pHEhqhHim6zbvXlXGSytIteuWLfY5Kr9gwBWC8fFio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjuW+99uEnggCvVVNP7MWOWWwnScKqboQ3ATpqsmVftljFpHEZt8WysaMgS+RT0INucsT+ZEfGvgcRiMhE9X05xbJ2fvZmYZ8/psG/GuikpmCQ/aY4Ru4O+DK6AYxUUnYyUnGf8JG8kP29Vixi7imoeM8PCQdfRYEPrnQ7oRVoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WtIrJspU; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WtIrJspU"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so2882301f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 27 Jul 2026 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785164294; x=1785769094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=WtIrJspUFDv9uYL8E4OhCURfnCutsSkbOm+juL/6yCshO8FMCiFZrYMSEpcfsdW4Nh
         iKdHsW3hXXVC8Pl4kUTysqT9Zr8oF1RzlXcRzFSGc2UBRbewwmpIc4cUdB8jmp3pl1An
         f6O93wZ1uT86BMhjp0hkFyCYKEgWqWi968vQRJXARDoAz7+tu8TEFguRFWLq/na2hZxb
         h+/lKgJgJ7KvEmuOlPlx1TgAEAOP3gxpUS2jY/c4WBF4cEndQhBSKAsMyUFZVAH/YqQT
         oXvZ+5VFrjrP5i1FIj+Vs0SajlFsW+dWgVvOzDcsFpUW8FB2tzSLDDUFkca3REdCvM53
         ZAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785164294; x=1785769094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdTAOusKdU7cIGVdiXhGRlX7Lluomu67uAna+oJrbLI=;
        b=QEh2BpEhwbX5CeHJi0DBz1qlejPBJOD9ouRW5j1mvw8pB4aK8Z62EMrhnRcpxEahxb
         7DBCmbZ1Iwb0cI3eARJv1+fluHSxGcFR7XI3GCIyumg71ku1etuuhFWSuXUvs6T1EKKe
         ZdXP8TsHm7U75OZeqFeQr0aCVM7EeqJS+iiHgzCjCD8c7LNCBXzZJu7aEsQz0aiPSZvm
         TALp9GZD4SwGEAdLxhHHL4ybbKfW3//BSypbdiwNQVdVohYITuEbcSjm9buNcboAOZZF
         2yzZxAGTFQRMlT9JeK7ebLM9mhIqd01RW6HuiFALIw7N6pu+x1VPLhj0qvPrqWxxiV3C
         yadA==
X-Forwarded-Encrypted: i=1; AHgh+Ro3lGKR//HlAH8Ic7TALJgE/NxZWWbCTnHEhZCsATBM6Y0v9StUlmC0syZEkcseyJKHfpqAq5kqpuJQrqsF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hk7ZwfJKI6vXQB8/s6FqMuGjC4dFvvtWplOTu9jNazfSDhB+
	ns7dm2dJ06CcsJSsEFvTK/i+Z3cLwSp3VSOLhgMgQqPHWQVuDj/m09AqsVpFiLGBozc=
X-Gm-Gg: AR+sD10UVHW15cZiemnyEpkVpI5FfyOpoJPWjYAGyE6HhWmx8DvqKnIG3PUg/ksIoR0
	v1snh+N2lu8eHRBFxsrge7DU1HiBdjR06+henHodnn/2zOVkpbnQFN/nfE1wLgHbpLyV/SZKYOO
	shusBhUQNgxGn3yXu7xTSUl0ImhNNh4x/AUH8zxWHs6BHZFELhsdiHApPWsVRm1g77CutdctlVD
	W71zxsAxn+B16iEh+R+QdDhFeA9ztuZn+W/wCLowjvmcNfgedf6qJ5hZyE+r1p4uiq0ALOhPnHy
	J9A28NU2JXGmoKZSJoOO5tcUByR1HTrGxTvYb9jmslUT9uqH5PSKijuHkI2Bo15gIGQjh44nR2B
	Bqu/sPdT09XY75XsfXuBEwrf+DEU+uYHEhA7nEdRbszj04bNWI9jFGRV+PKCA3WmSFyrz8F0qqB
	IIENeXErX4ufxkH8m/YSYb5900qYTwrVy4u0RY9ZQ=
X-Received: by 2002:a05:600c:1553:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-496b5731987mr114339235e9.39.1785164294020;
        Mon, 27 Jul 2026 07:58:14 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee0e91sm231594995e9.4.2026.07.27.07.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 07:58:13 -0700 (PDT)
Message-ID: <ead73f81-26ef-4a46-9ad8-fcd2915563e1@suse.com>
Date: Mon, 27 Jul 2026 16:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] time/jiffies: Include linux/sysctl.h for
 proc_int_u2k_conv_uop(), ...
To: Thomas Gleixner <tglx@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Jens Axboe <axboe@kernel.dk>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michal Januszewski <spock@gentoo.org>, Helge Deller <deller@gmx.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-acpi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ocfs2-devel@lists.linux.dev,
 cgroups@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
 bridge@lists.linux.dev, netdev@vger.kernel.org, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260721131207.803760-1-petr.pavlu@suse.com>
 <20260721131207.803760-3-petr.pavlu@suse.com> <874ihmke0k.ffs@fw13>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <874ihmke0k.ffs@fw13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/26 10:31 PM, Thomas Gleixner wrote:
> On Tue, Jul 21 2026 at 15:11, Petr Pavlu wrote:
> 
>> The kernel/time/jiffies.c file uses proc_int_u2k_conv_uop(),
> 
> jiffies.c uses ...
> 
>> proc_int_k2u_conv_kop(), proc_int_conv(), proc_dointvec_conv() and
>> proc_doulongvec_minmax_conv(), which are declared in linux/sysctl.h. It
>> currently relies on this header being included indirectly through
>> linux/module.h -> linux/kmod.h. Add the missing include in preparation for
>> removing the linux/sysctl.h include from linux/kmod.h.
> 
> Can you please split that spaghetti sentence into paragraphs?
> 
> https://docs.kernel.org/process/maintainer-tip.html#changelog

I will update it to:

    jiffies.c uses proc_int_u2k_conv_uop(), proc_int_k2u_conv_kop(),
    proc_int_conv(), proc_dointvec_conv() and proc_doulongvec_minmax_conv(),
    which are declared in linux/sysctl.h. It currently gets that header
    indirectly through linux/module.h -> linux/kmod.h, but the latter no longer
    needs to include linux/sysctl.h.

    Include linux/sysctl.h directly in jiffies.c ahead of removing the
    unnecessary include from linux/kmod.h.

> 
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@kernel.org>

-- 
Thanks,
Petr
