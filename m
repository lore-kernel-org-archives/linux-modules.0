Return-Path: <danielhilst@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKi4VAJo1yVe5ZrnDVKV_2dCxyVfrufhWq=D7ChguiRq35AQ6Q@mail.gmail.com>
References: <f3e2ee06-8fc2-aa6c-d72f-324277004c06@manjaro.org> <CAKi4VAJo1yVe5ZrnDVKV_2dCxyVfrufhWq=D7ChguiRq35AQ6Q@mail.gmail.com>
From: "Daniel." <danielhilst@gmail.com>
Date: Tue, 28 Jun 2016 11:19:50 -0300
Message-ID: <CAF3SDA5UGz5fWzWiWdsuW=iS_9tqo_YxgUkU3VO4m1uKD5NqTQ@mail.gmail.com>
Subject: Re: error: EXTRA_DIST must be set with '=' before using '+='
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Bernhard Landauer <oberon@manjaro.org>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

What is Manjaro? G_G

2016-06-28 0:08 GMT-03:00 Lucas De Marchi <lucas.de.marchi@gmail.com>:
> On Mon, Jun 27, 2016 at 8:05 PM, Bernhard Landauer <oberon@manjaro.org> wrote:
>> Hi!
>>
>> Latest git commit fails building for me on Manjaro (Archlinux) with:
>>
>> Makefile.am: installing 'build-aux/depcomp'
>> Makefile.am:207: installing 'build-aux/py-compile'
>> parallel-tests: installing 'build-aux/test-driver'
>> libkmod/docs/gtk-doc.make:33: error: EXTRA_DIST must be set with '=' before
>> using '+='
>> libkmod/docs/Makefile.am:29:   'libkmod/docs/gtk-doc.make' included from
>> here
>> autoreconf: automake failed with exit status: 1
>>
>> Do you have any hint for me what might be wrong at my end maybe?
>
> what version of gtk-doc do you have? We use it for generating the
> documentation, but it seems a recent version may be broken for our
> integration with it. At least on F24 I can't even -build the docs
> anymore... just went to check it in order to reproduce your issue.
>
> For now you may want to pass --disable-gtk-doc to see if it works
>
> Lucas De Marchi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
"Do or do not. There is no try"
  Yoda Master
