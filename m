Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418FA214422;
	Tue, 12 Nov 2024 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443314; cv=none; b=WHlr5GG0c1XP+CYUcDASsaAPcD9vqkjAftYU27uLoHOkP19LOa8z+29yiKBVfsaCcWdB7zSG9kN5zqjIos169MyTdiL8IIQB0KNerAnHIvq80wYx/+xXJvJUfWw3uj2MGU1SPgdZkdLIsdBrbFcHuV5T7rX+J8YTLUEau4uEj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443314; c=relaxed/simple;
	bh=GeXKXK0MEuMtdQ9cj+pxJZABTzoKHPJqHjDXwnj2lXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T40+4KzFKWyLTE9nuYzUkbdF9cJnNJxClfEuKFWdKmL55VgUqjtLtjLLNWhMJerIHmIIowyR6OPLM0KL1Eb1HT2ioJkRSQxKWb+6a1QAqQpByfV3CuHUrWmPtHGCNEJCouaaHBQqQpU9MrEystXyK4rXWKCYu/3X5apBHLSpKqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmg/nnMW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmg/nnMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEC3C4CECD;
	Tue, 12 Nov 2024 20:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443313;
	bh=GeXKXK0MEuMtdQ9cj+pxJZABTzoKHPJqHjDXwnj2lXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dmg/nnMWOJEb8sGf8sj3yL7p8s5uSwPfQpqP7YVC8CxiqJMlE3Z+2G4gh39OUMLXP
	 DLpdgiatnRmrXQtckEurj65c4w4d/Q/dLfX6x1cTf1eNv1qWUm11v7IKKUmVoI4d7s
	 LXeisHK91MnXljVdjGvLbejek6MQhyhkJG/1aXQVoGD/pnEbRXYvyvYAlepAifvkcp
	 dsgizRZurOetO9m+D6VySTgLRnK4VqKFlJwi74S95UWrzzkKKSXO8j/tli7RG8qOmF
	 dcKq/qDR328qAdPWz5uBoWFKB3/nDZsJFjqAozXrJTEhSrAA43AMgGPXWPMp0YBLTK
	 7630WLl87Mu9A==
Date: Tue, 12 Nov 2024 12:28:32 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 3/3] module: pre-test setting ro_after_init data
 read-only
Message-ID: <ZzO6cNo2MalF92OV@bombadil.infradead.org>
References: <737f952790c96a09ad5e51689918b97ef9b29174.1731148254.git.christophe.leroy@csgroup.eu>
 <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32f2390caf6e0d157ffea6e04f5e5d8629620c2.1731148254.git.christophe.leroy@csgroup.eu>

On Sat, Nov 09, 2024 at 11:35:37AM +0100, Christophe Leroy wrote:
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1bf4b0db291b..b603c9647e73 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2582,7 +2582,7 @@ static noinline int do_init_module(struct module *mod)
>  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
>  #endif
>  	ret = module_enable_rodata_ro_after_init(mod);
> -	if (ret)
> +	if (WARN_ON_ONCE(ret))

Do we want panic on warn systems to crash with this?

  Luis
