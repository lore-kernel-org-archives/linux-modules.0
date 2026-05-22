Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1DF394781
	for <linux-modules@vger.kernel.org>; Fri, 22 May 2026 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455170; cv=none; b=TeiAisqD3cll3bVCd0YJz6Q6/D8L5kiOLN4ncoZOqS1H4z6GjzSXUosMekuTrpcCpIloOH6oz3YG6goAa0HuMhMytE+2qT8q4Vj4HEjq0BxMNYzD+EGx0sHb1bwG1+lTKiBhDkGBTu6TVRHIhrw6vmm/WjhLN0t/V4a3t5aNlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455170; c=relaxed/simple;
	bh=CrUvmAcH/6UNtp+fwPwFwq2VX4Qbk2+mAnahh35JAFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+DyuVO6oSPIGiWQUfiKe0PNRKluABukmIjDldGtYuEjP349/mOC3gLOOyILFTDWOyvV5EGWDP8BVueg70UqIQ6UabPnXCutOX4GSoRUQQXN8luRaSWy3Rz6LJmEji4RVjnZAE9bM9OCJWArNLp9C8ogPeH9Tdsxop9SqClSFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GCvjmOv7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GCvjmOv7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43fe608cb92so4535416f8f.2
        for <linux-modules@vger.kernel.org>; Fri, 22 May 2026 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779455167; x=1780059967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Z6hIMYgqhMrKKBiL1MJIdjEE5Rl1yfiYAVBlDccynQ=;
        b=GCvjmOv7KQT9SVb9mXVrcYk5eIJtVltpgU6yD81NYa0lQ7PYQkeQu+GQFMUm9fpKX7
         gSWAMcR2KUYmErl8Ek8ZLeUGw1A29ra7VF7T6Dx7J2atLlzsV3VMNraxxEOAAlQ0tlXS
         KJYL5ZWeB/p5dzRwaXP+1FhO4fG+belzQqTNgqLGeD1T9nZfsDSC0qSNjdzEIso+m9I+
         w/uGD+Qe7j1T/n0wkVU6+p9D0gzrSxO03HbVZEqhsQx4MZtz1Js/SLclCYDswXCCWv1w
         oldaK3ReKKl0wqVk2TMKfjUSzJpN09INiV+puKTCvd5PCDzugUFR9wQHnGMbL6pbzSEC
         LQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455167; x=1780059967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Z6hIMYgqhMrKKBiL1MJIdjEE5Rl1yfiYAVBlDccynQ=;
        b=gaoA1Qr6Lct+jVMYnpJFTKBK8aOMpUyZ9bDvh/XN3oNkL8uqSLgfN0dtu+oZ5ZQ9Il
         Or+b3l+pvyRBgqFP7ZincvTZ1sGv2oy/Zq72e+fYBzJzf7OaYYZNqr0jbFO1vhlc0q14
         0PqwTaNVtxJ5amjdUsfZNY6C+MlTyWXMuxJl9uNO2YrapmTO4MaW6Ib60U1A8n+Bj0DJ
         fRWqSWCeYPrDNyMCyQDUWIm1iOOuRJDBmbd+VLisOcU+gssaG45LM8vuFt4KcRXTt4iW
         Tjlv+GoUxts4sOq7Zgz5YTJzDnDH8kZhaWVFmbIPzrnYqN2vK8UHhn2KcPTHuxgKmoY/
         jHSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8D+M8D28A+sNnG50HlnAHuIxMdGVoh+QxrvwlyPWT8hWfUT8+U0yuqHqATHcBYq3m6961/oOLdprJy4DJg@vger.kernel.org
X-Gm-Message-State: AOJu0YxXUUdtubNF9YzkiZ3C/J+Pr9YzrMCROYwMSsRkFIaoQwwDiUPD
	/M05SoCJu3SJOKqcsZhWojr9fgvHLAo5EIRAM5+UwfFPhYJbw3cjk2Hna4P6jdgrRH8=
X-Gm-Gg: Acq92OGGxL1f8V6CDY5kuwx1T0CdkopEzN/TuxE3qPBApcy8NYPDOGkRhqowpA+HR+6
	EhJaZajO7jM8tkMARlP5Of8dtdOxEFqtkVK7ILvAujjdt/Ro2iiiUbNL5ANZ+9Fwhu127rgfRe9
	hdLuvZ50IkbekY0nlmRW6HfpIlM3vGyPJGFa5nYq5k1+fdoLUwapRyfJeWDCwJPYskohPCKbbeR
	JgD4EiANJUcoKS96Is/YwS47LIT2K9Sj0H5gFjS9EahqBB03SUt4w2TVwi09sqxVYNzH7In8sCf
	zT4Wxh4iSJgSTzJNRGU7Rq5ix8bN32QaR4j9CBcpV1e/dsd83jic5QmDRBoj+zKjJKBZ1iRaQrP
	S36AXx44LBvfQohKeNBaxFzlDjLwJG8+U/tupqdie1T0sLrvI9iRQVd2Qnii8cpWX6H+smy7sgE
	P40MSYZKM+oany2p7COd5hyZalGBKZ3ABos2V9xr+mbF1/9nELhkpAcZY=
X-Received: by 2002:a05:6000:2384:b0:441:3144:efc5 with SMTP id ffacd0b85a97d-45eb38e4fd0mr5515739f8f.42.1779455166814;
        Fri, 22 May 2026 06:06:06 -0700 (PDT)
Received: from [192.168.42.79] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d71688sm4196400f8f.33.2026.05.22.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 06:06:06 -0700 (PDT)
Message-ID: <a0b17be8-f7dd-4d05-bc6f-28b32d0b0785@suse.com>
Date: Fri, 22 May 2026 15:06:04 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] kernel: param: initialize module_kset in a
 pure_initcall
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rahul Bukte <rahul.bukte@sony.com>,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 Daniel Palmer <daniel.palmer@sony.com>, Tim Bird <tim.bird@sony.com>,
 linux-modules@vger.kernel.org, linux-tegra@vger.kernel.org,
 Sumit Gupta <sumitg@nvidia.com>
References: <20260518-acpi_mod_name-v5-0-705ccc430885@sony.com>
 <20260518-acpi_mod_name-v5-2-705ccc430885@sony.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260518-acpi_mod_name-v5-2-705ccc430885@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/18/26 12:19 PM, Shashank Balaji wrote:
> Commit "driver core: platform: set mod_name in driver registration" will set
> struct device_driver's mod_name member for platform driver registration. For a
> driver to be registered with its mod_name set, module_kset needs to be
> initialized, which currently happens in a subsys_initcall in param_sysfs_init().
> The tegra cbb drivers register themselves before module_kset init, in a
> core_initcall. This works currently because lookup_or_create_module_kobject(),
> which dereferences module_kset via kset_find_obj(), is not called if mod_name
> is not set, which is the case now.
> 
> So in preparation for the commit "driver core: platform: set mod_name in driver registration",
> move module_kset init to pure_initcall level, ensuring it happens before tegra
> cbb driver registration.
> 
> Suggested-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
> Patch 4 depends on this patch
> ---
>  kernel/params.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 74d620bc2521..ac088d4b09a9 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -957,7 +957,7 @@ static int __init param_sysfs_init(void)
>  
>  	return 0;
>  }
> -subsys_initcall(param_sysfs_init);
> +pure_initcall(param_sysfs_init);
>  
>  /*
>   * param_sysfs_builtin_init - add sysfs version and parameter
> 

The change looks ok to me functionality-wise. Sysfs is initialized
earlier in do_basic_setup() and other code, such as classes_init(),
calls kset_create_and_add() similarly early.

One minor issue is that pure_initcall() was originally intended for
static variable initialization. The file include/linux/init.h says:

| /*
|  * A "pure" initcall has no dependencies on anything else, and purely
|  * initializes variables that couldn't be statically initialized.
|  *
|  * This only exists for built-in code, not for modules.
|  * Keep main.c:initcall_level_names[] in sync.
|  */
| #define pure_initcall(fn)		__define_initcall(fn, 0)

The patch stretches the intended use of pure_initcall() somewhat in this
regard. However, other code already appears to do the same, so I guess
this is ok.

Additionally, I think it would be good to update the comment preceding
param_sysfs_init(). It currently says:

| /*
|  * param_sysfs_init - create "module" kset
|  *
|  * This must be done before the initramfs is unpacked and
|  * request_module() thus becomes possible, because otherwise the
|  * module load would fail in mod_sysfs_init.
|  */

I suggest changing it to something like follows:

This must be done before any driver registration so that when a driver comes
from a built-in module, the driver core can add the module under /sys/module
and create the associated driver symlinks.

-- 
Thanks,
Petr
