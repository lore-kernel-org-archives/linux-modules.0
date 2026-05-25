Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF03F20E7
	for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779726255; cv=none; b=V4AMj+tKplETJEuAalHv252y5I44YvCDYKTe0x0UNsrchLMcKqCGyXk0m+3nwlcwG+9c7IgFzhLhqmB0Wzab2OtjS5MqAPaJWrEuHdOnHi9/TfQNLvoJRQWYbqjJ+zFaApirkZ6itfk43jFsd2U+GHEJfLbyuSIXMF+a48NznMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779726255; c=relaxed/simple;
	bh=Ix5V9VVReiSoQo6AB3QETxLfhu0cCyAdGQjvJGHnDxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc7Q3naZV+tHtxIKVG2WRUdeMfEDSrio+rt6nC22xNVkDciDI8B/nGeHsw9aPJ202I60zNFH7iNmwckNMTFlV7e6PQ60ueP3M0XTdmMD6xcHMqDBZNpZ1FJrvu221TY9w9YmeIT49aCHAaoKWTEOe898gtUj+0topwFYTBDMqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VdZk1QbN; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VdZk1QbN"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so7448754f8f.1
        for <linux-modules@vger.kernel.org>; Mon, 25 May 2026 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779726251; x=1780331051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=VdZk1QbNytpFbuiKsbE3wW+kpdUiwO8Oy0pgmIL3aXlcs3cEHrAyW3jehgTlLTi83n
         wNh17lNTxLLkgF2MNP6aUmiJt0rCd+jWtZnbWylWlzXlbassqIWZOQCLLOffSEkhSbua
         +xQlxnJ9qX8lxTNaTtv21kd2cKIugw5nnDeVK3GmUj9N/fqumL9jVllnCfVPprFZDh/q
         LoGx1NaFUjwhYiOVtB2Bo+Ks5HuJmMsqFtXlcMGYkbS3CeNG7DthkcDMBrct+OJR510y
         SClO2VskO/kDqNdoapbvTguZijtUGevTSuelHBqTta1LS7zaFq3R8yRear0hL0uSsY1S
         vaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779726251; x=1780331051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WThGrJlj0+d9TTzzXLAp8aZigkvM5HszOOE/MfwSIgg=;
        b=oEoPtsPFA98ZcFQj0cAmtmzkp1XJYqlVStcvy99qEzB3B/HYmVMxxbocnaD40K8Dgi
         +BHCMiW1fMpy2Qv3z2OIjws4E4RdpHSpFEd8KkkJg8WxTBcC0eeuXCxT/SipEPuiuTD9
         Eh4F4lhmTHWTM8iGVQtXhANxWlR3+JZa7zKNegSw5L+5d2kPMVglSOtThYmsmNz8vuSo
         a5jYqA7qZ0Np6BNeiuCu1GxeYxq3XgOUUdCP5EGLrKUQc7cxiVyxDw/DYoUIDBLLYOZE
         dZMd3M/yooQv4Bsp7q4r+vNGiAUmOpY/K5PvJppQTDHEfDnUEb2KVKmtAtklcGYANNf/
         pr1g==
X-Forwarded-Encrypted: i=1; AFNElJ9VdsE0KNKEY4SVPbokR7K09JNVM92ALojXy8JymRjvTdvZYmuYPLyDqZDKxz8RB+rzaAt2suq4Nf6oNN/7@vger.kernel.org
X-Gm-Message-State: AOJu0YwhRF0lyC115TGTQr/MIwGheaXRhGJQpU79pXkhy0gi4BIj1hFy
	SVoVBjlmg7vc8TLS54eDHHFG4Q5dSq/PBMiCE/etWpH2wqOdoceIyN1ZJpiZHOKsj28=
X-Gm-Gg: Acq92OH8T0IZ2UZOhkACNDVVNhVO2cMqE0sUrFDSNy8DuqW7zb+ceqZ1/PbLep2+vaV
	x5nK7H7AVc+yA+MKMLzblRmJFUBjneApYBOyAsX9QkhB0P++9S6KdAf1Efk/KvAuyPsxgRyFK7E
	Mnu+BU69duANkMlT98agg+E4hJACnxW4YQlEV4aDrlLeC1daxtpSTnazkrZfa1wD0SyoTk1bT61
	Fcb7F+PcGY5sdRRMhj0Q6nmpdfqnPbFA1cb6OW7jiPTxdreX5KkY5Q5XJyAPJTFRzS2B6ywsO/p
	DAluzRGrSR1eDvDwVRUu/pk6D7KgTMITliL1sV3Goqh80ZkhGMiPR6qb4RNtrp/dB5AjMY81Oih
	eZYrCIrMm7zqHzmIvPEKjm6Yj/tvr8avBhhBuxAirqd6gDycI54bOM8dkTF3TW2HHDzJD9+zCes
	iyT4HiraOaVJ+H4FZQQAKtfU95n5AuiHp/q/sdfZq9cR4g5nkVpGyHk/NmXJxCR+xbFkQa5NE+I
	xscvyw4d56c9G5emRCNZufIBGoVkyFPbzP2MFKO4wrGn+lG9rP7cLGJ2wqBdbruRqRrtg==
X-Received: by 2002:a05:6000:26cf:b0:45e:b215:12e9 with SMTP id ffacd0b85a97d-45eb368903emr24724531f8f.6.1779726250728;
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d47b82sm28202483f8f.19.2026.05.25.09.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 09:24:10 -0700 (PDT)
Message-ID: <4e54ae4a-4f7b-451d-9b37-97f30b8fefba@suse.com>
Date: Mon, 25 May 2026 18:24:07 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] moduleparam: Route DEFINE_KERNEL_PARAM_OPS get
 pointer via _Generic
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Pengpeng Hou
 <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>, Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260521133315.work.845-kees@kernel.org>
 <20260521133326.2465264-7-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260521133326.2465264-7-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/26 3:33 PM, Kees Cook wrote:
> Make the DEFINE_KERNEL_PARAM_OPS family route their _get argument to
> either .get (struct seq_buf *) or .get_str (char *) at compile time
> based on the pointer's actual function signature. Two helper macros
> do the routing:
> 
>   _KERNEL_PARAM_OPS_GET     - return the pointer if it has the seq_buf
>                               signature, otherwise NULL of that type
>   _KERNEL_PARAM_OPS_GET_STR - mirror image for the char * signature
> 
> Both use _Generic; only the two valid function-pointer types are
> listed, so any third-party type is a compile error rather than
> silently falling through.
> 
> Now a callback whose body has been migrated from char * to struct
> seq_buf * needs no change at its kernel_param_ops initialization site,
> because the macro picks up the new type automatically and assigns to
> the correct field.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  include/linux/moduleparam.h | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index c52120f6ac28..795bc7c654ef 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -85,15 +85,32 @@ struct kernel_param_ops {
>   *
>   *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
>   *
> - * Routing the @_set and @_get function pointers through the macro
> - * (rather than naming the struct fields at every call site) lets the
> - * field layout change in one place when callbacks are migrated to a
> - * new signature.
> + * @_get may be either of:
> + *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
> + *   int (*)(char *, const struct kernel_param *)           (legacy)
> + *
> + * The macro uses _Generic to route the function pointer to the
> + * matching field (.get or .get_str) at compile time, leaving the
> + * other field NULL. Each helper matches the wrong prototype signature
> + * and returns NULL, falling through to the default branch otherwise;
> + * if @_get has neither expected signature the assignment to the
> + * fields gets a normal compile-time type-mismatch error.
>   */
> +#define _KERNEL_PARAM_OPS_GET(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(char *, const struct kernel_param *): NULL,		\
> +	    default: (_get))
> +
> +#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
> +	_Generic((_get),						\
> +	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
> +	    default: (_get))
> +
>  #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
> @@ -101,14 +118,16 @@ struct kernel_param_ops {
>  	const struct kernel_param_ops _name = {				\
>  		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  	}
>  
>  /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
>  #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
>  	const struct kernel_param_ops _name = {				\
>  		.set = (_set),						\
> -		.get_str = (_get),					\
> +		.get = _KERNEL_PARAM_OPS_GET(_get),			\
> +		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
>  		.free = (_free),					\
>  	}
>  

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- Petr
