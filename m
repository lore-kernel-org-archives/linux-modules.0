Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B273C5
	for <linux-modules@vger.kernel.org>; Fri,  6 Oct 2023 16:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtctmrP7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B1CC433C8;
	Fri,  6 Oct 2023 16:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696611498;
	bh=W/PV9BEnW7qV8HRBjAeCSKH71F8YRJwxXRxGjI45a6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtctmrP7HPX723W0dFuw/syZx1G3b4jfABirVj7JKuUFR4u0ANnNX9D9WFqmGsizJ
	 iomwfbA3VchilnHSRmBdJbSjGjzv5uZ49OeA095CjlXG8M7ItBd8qPL9QMUK/QrZ65
	 tnkIn0MBo8NLpb3kkkez6smKI0yHnyR3oxGlCH7Tw/BF5baOzK8QzamZtZYZ52UHfJ
	 yuPotqd/7l+OL/s5ThUw+Zlv1HX02eOtqk4dWMHcHjngAb1dbCohYH2U37ymWy+5oD
	 qVCziJ7OACmhP86Vhm0WeDvNsTJ8c6ZOUc6cwNYampiMTHyv1l+aZYg0NdiQL/F+lj
	 fowcyiaLg/Xng==
Date: Fri, 6 Oct 2023 09:58:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>, linux-modules@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH rebased] kbuild: rpm-pkg: Fix build with non-default
 MODLIB
Message-ID: <20231006165815.GA3359308@dev-arch.thelio-3990X>
References: <20231005150728.3429-1-msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005150728.3429-1-msuchanek@suse.de>

On Thu, Oct 05, 2023 at 05:07:28PM +0200, Michal Suchanek wrote:
> The default MODLIB value is composed of two variables and the hardcoded
> string '/lib/modules/'.
> 
> MODLIB = $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> 
> Defining this middle part as a variable was rejected on the basis that
> users can pass the whole MODLIB to make, such as
> 
> make 'MODLIB=$(INSTALL_MOD_PATH)/usr/lib/modules/$(KERNELRELEASE)'
> 
> However, this middle part of MODLIB is independently hardcoded by
> rpm-pkg, and when the user alters MODLIB this is not reflected when
> building the package.
> 
> Given that $(INSTALL_MOD_PATH) is overridden during the rpm package build
> it is likely going to be empty. Then MODLIB can be passed to the rpm
> package, and used in place of the whole
> /usr/lib/modules/$(KERNELRELEASE) part.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

This appears to work for me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/package/kernel.spec | 8 ++++----
>  scripts/package/mkspec      | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> index 3eee0143e0c5..15f49c5077db 100644
> --- a/scripts/package/kernel.spec
> +++ b/scripts/package/kernel.spec
> @@ -67,7 +67,7 @@ cp $(%{make} %{makeflags} -s image_name) %{buildroot}/boot/vmlinuz-%{KERNELRELEA
>  %{make} %{makeflags} INSTALL_HDR_PATH=%{buildroot}/usr headers_install
>  cp System.map %{buildroot}/boot/System.map-%{KERNELRELEASE}
>  cp .config %{buildroot}/boot/config-%{KERNELRELEASE}
> -ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}/lib/modules/%{KERNELRELEASE}/build
> +ln -fns /usr/src/kernels/%{KERNELRELEASE} %{buildroot}%{MODLIB}/build
>  %if %{with_devel}
>  %{make} %{makeflags} run-command KBUILD_RUN_COMMAND='${srctree}/scripts/package/install-extmod-build %{buildroot}/usr/src/kernels/%{KERNELRELEASE}'
>  %endif
> @@ -98,8 +98,8 @@ fi
>  
>  %files
>  %defattr (-, root, root)
> -/lib/modules/%{KERNELRELEASE}
> -%exclude /lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}
> +%exclude %{MODLIB}/build
>  /boot/*
>  
>  %files headers
> @@ -110,5 +110,5 @@ fi
>  %files devel
>  %defattr (-, root, root)
>  /usr/src/kernels/%{KERNELRELEASE}
> -/lib/modules/%{KERNELRELEASE}/build
> +%{MODLIB}/build
>  %endif
> diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> index d41608efb747..d41b2e5304ac 100755
> --- a/scripts/package/mkspec
> +++ b/scripts/package/mkspec
> @@ -18,6 +18,7 @@ fi
>  cat<<EOF
>  %define ARCH ${ARCH}
>  %define KERNELRELEASE ${KERNELRELEASE}
> +%define MODLIB ${MODLIB}
>  %define pkg_release $("${srctree}/init/build-version")
>  EOF
>  
> -- 
> 2.42.0
> 
