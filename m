Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E771CF90
	for <linux-modules@vger.kernel.org>; Wed,  3 Jan 2024 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Received: by gentwo.org (Postfix, from userid 1003)
	id 2244F40A8B; Wed,  3 Jan 2024 11:43:13 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2135040A82;
	Wed,  3 Jan 2024 11:43:13 -0800 (PST)
Date: Wed, 3 Jan 2024 11:43:13 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: artem.kuzin@huawei.com
cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
    dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org, 
    peterz@infradead.org, akpm@linux-foundation.org, urezki@gmail.com, 
    hch@infradead.org, lstoakes@gmail.com, mcgrof@kernel.org, 
    rmk+kernel@armlinux.org.uk, nikita.panov@huawei-partners.com, 
    alexander.grubnikov@huawei.com, stepanov.anatoly@huawei.com, 
    guohanjun@huawei.com, weiyongjun1@huawei.com, wangkefeng.wang@huawei.com, 
    judy.chenhui@huawei.com, yusongping@huawei.com, kang.sun@huawei.com, 
    linux-mm@kvack.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH RFC 02/12] mm: add config option and per-NUMA node VMS
 support
In-Reply-To: <20231228131056.602411-3-artem.kuzin@huawei.com>
Message-ID: <059dc132-af10-fd08-7368-302c765a4269@gentwo.org>
References: <20231228131056.602411-1-artem.kuzin@huawei.com> <20231228131056.602411-3-artem.kuzin@huawei.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 28 Dec 2023, artem.kuzin@huawei.com wrote:

> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -626,7 +628,14 @@ struct mm_struct {
> 		unsigned long mmap_compat_legacy_base;
> #endif
> 		unsigned long task_size;	/* size of task vm space */
> -		pgd_t * pgd;
> +#ifndef CONFIG_KERNEL_REPLICATION
> +		pgd_t *pgd;
> +#else
> +		union {
> +			pgd_t *pgd;
> +			pgd_t *pgd_numa[MAX_NUMNODES];
> +		};
> +#endif


Hmmm... This is adding the pgd pointers for all mm_structs. But we 
only need the numa pgs pointers for the init_mm. Can this be a separate 
variable? There are some architecures with larger number of nodes.

