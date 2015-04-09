MIME-Version: 1.0
In-Reply-To: <BLU436-SMTP20649D5EE75F0236F19D334ACFD0@phx.gbl>
References: <BLU436-SMTP20649D5EE75F0236F19D334ACFD0@phx.gbl>
Date: Thu, 9 Apr 2015 11:09:15 -0300
Message-ID: <CAKi4VAJH9q5ma+6T+znqHhPzPxC5k9gdj0JS_FNpnDfdDL7MvA@mail.gmail.com>
Subject: Re: How to get instance for kallsyms_address or kallsyms_num_syms?
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Buddy <Buddy.D.Zhang@outlook.com>
Cc: linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Buddy,

This question is more for lkml than linux-modules. I'm CC'ing it.

-- 
Lucas De Marchi


On Tue, Apr 7, 2015 at 6:48 AM, Buddy <Buddy.D.Zhang@outlook.com> wrote:
> HI:
> I want to get information for kernel symbol,so I use array of
> kallsyms_address
> and value of kallsyms_num_syms.But when I use them,I can't find definition
> or instance
> for kallsyms_address.So I try to use virtual address for kallsyms_address in
> my machine,
> and I can't get it.
> So would you please tell me how to get instance for kallsyms_address or
> kallsyms_num_syms.
>
>
>                                                               Thanks for the
> help!
>                                                                 Best regards
> Buddy.D.Zhang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
