Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC00C6FD18
	for <linux-modules@archiver.kernel.org>; Fri, 31 Mar 2023 04:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCaEME (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 31 Mar 2023 00:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCaEMC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 31 Mar 2023 00:12:02 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152211EB3
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id d13so19278336pjh.0
        for <linux-modules@vger.kernel.org>; Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680235921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fL6uYJqAJu4UWRofGL+uAKGAJCdSLBsLiJ3MZGh5jk=;
        b=e4BTX608wtZj4jZHDmB/1T4Gq8gzXBUP6DMAygN96mFzBhJbH8TFT2/VfRMayOo63G
         lTCJQFkxdohuSxvSyi7wtdj2gzFs7VUaboL5Yk1trxL9GdyiC7tFJelssEv8eqjpqdQG
         YLkdiqsWKS6TtftuVgzjuJki5n6e12uuDQlDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680235921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fL6uYJqAJu4UWRofGL+uAKGAJCdSLBsLiJ3MZGh5jk=;
        b=Hnt82ao/huifgi3k4tL8DzAsLefPUt+x7/OhHiUPcnDUzCt0qIzx4EXUX4z5zVZaR4
         Yxr0HBgCRwAzY5Pf9IOezxLbOAEv3tAU6Tw33ggS6g7TpYxERQUQymFwP+CjNsA/C9+8
         /+dls0KXxBEBXU/YGtaE3n2FTh7K187RSre4kAhS2BNex+/qC7BPTGJfJg2+dpPfhEiU
         qziSZSMjOYu1WpRfaMiexaXXfOBr18CYmWpwnB7wrwk10CO3Hlp08xByjeom30D90T1a
         qImOi9cNVgVBLMZVasLzilpvuWW9qeNmwLiym3QzX0dJQSewB+ukveBGbH7NZMcGMay7
         n9eQ==
X-Gm-Message-State: AAQBX9eGsfAoWPPDxcDieKXonxOUYJUjzfKHj9celdjlaSEjHn8Gk9r8
        tnh5YMieGty7PPDnyBxnNus/WA==
X-Google-Smtp-Source: AKy350Z3RDbX1XH78O/Mn6Z/g1q+VldEMG0p2DTAFVaet1gIF+cSHwqqrndzG46RRYMeO2Fqm8seLQ==
X-Received: by 2002:a17:90b:3b83:b0:236:a3c2:168a with SMTP id pc3-20020a17090b3b8300b00236a3c2168amr28524828pjb.33.1680235921307;
        Thu, 30 Mar 2023 21:12:01 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902aa4300b0019f2a7f4d16sm506889plr.39.2023.03.30.21.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 21:12:00 -0700 (PDT)
Date:   Fri, 31 Mar 2023 13:11:54 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, petr.pavlu@suse.com,
        prarit@redhat.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de, song@kernel.org,
        rppt@kernel.org, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 4/7] sempahore: add a helper for a concurrency limiter
Message-ID: <20230331041154.GC12892@google.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-5-mcgrof@kernel.org>
 <20230329072112.GG4253@hirez.programming.kicks-ass.net>
 <ZCPuFLDgU5fBFtug@bombadil.infradead.org>
 <20230329091935.GP4253@hirez.programming.kicks-ass.net>
 <CAHk-=whF6Ta_KcJP2eC78+Mstv+vAku8ATRMbv98sf9VhdvySQ@mail.gmail.com>
 <20230330115626.GA124812@hirez.programming.kicks-ass.net>
 <CAHk-=wgF34MkhZnM_Kc1zggTWCAQ=BzEgAaAbE5wDM07bWiYeg@mail.gmail.com>
 <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCZXcJ+KJffpFrpX@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On (23/03/30 20:45), Luis Chamberlain wrote:
[..]
> -static DEFINE_SEMAPHORE(console_sem);
> +static DEFINE_MUTEX(console_sem);
>  HLIST_HEAD(console_list);
>  EXPORT_SYMBOL_GPL(console_list);
>  DEFINE_STATIC_SRCU(console_srcu);
> @@ -309,7 +309,7 @@ EXPORT_SYMBOL(console_srcu_read_unlock);
>   * macros instead of functions so that _RET_IP_ contains useful information.
>   */
>  #define down_console_sem() do { \
> -	down(&console_sem);\
> +	mutex_lock(&console_sem);\
>  	mutex_acquire(&console_lock_dep_map, 0, 0, _RET_IP_);\
>  } while (0)
>  
> @@ -324,7 +324,7 @@ static int __down_trylock_console_sem(unsigned long ip)
>  	 * deadlock in printk()->down_trylock_console_sem() otherwise.
>  	 */
>  	printk_safe_enter_irqsave(flags);
> -	lock_failed = down_trylock(&console_sem);
> +	lock_failed = !mutex_trylock(&console_sem);
>  	printk_safe_exit_irqrestore(flags);
>  
>  	if (lock_failed)
> @@ -341,7 +341,7 @@ static void __up_console_sem(unsigned long ip)
>  	mutex_release(&console_lock_dep_map, ip);
>  
>  	printk_safe_enter_irqsave(flags);
> -	up(&console_sem);
> +	mutex_unlock(&console_sem);

mutex_unlock() does not like when its called from IRQ, so this is not
going to work very well.
