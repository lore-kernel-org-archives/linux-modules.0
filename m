MIME-Version: 1.0
In-Reply-To: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
Date: Tue, 8 Nov 2016 22:29:31 -0200
Message-ID: <CAKi4VAJxFd8KpJ3DsGYOxuayyEj60oa3_vsLC_oz+DOWLnr6FA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] testsuite: depmod: add module dependency outside
 cyclic chain
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>, bjorn.andersson@linaro.org, afaerber@suse.de
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Nov 8, 2016 at 2:45 PM, Mian Yousaf Kaukab
<yousaf.kaukab@suse.com> wrote:
> Check that depmod do not report modules outside cyclic chain
>
> Two modules f and g are added which do not have any dependency.
> modules a and b are made dependent on f and g.
>
> Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
> ---
> Here is the output of loop dependency check test after adding this
> patch:
>
> ESTSUITE: ERR: wrong:
> depmod: ERROR: Found 7 modules in dependency cycles!
> depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d
> depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_b
> depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_g
> depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a -> mod_loop_f
>
> Buffer overflow occurs in the loop when last two lines are printed.
> 43 bytes buffer is allocated and 53 bytes are used.


Great!

I found this last part of the message very useful to be in the commit
message, so I moved it there.

Thanks,
Applied

Lucas De Marchi

-- 
Lucas De Marchi
