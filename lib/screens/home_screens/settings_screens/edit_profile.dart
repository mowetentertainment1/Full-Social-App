import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components.dart';
import 'package:social_app/shared/home_cubit/social_cubit.dart';
import 'package:social_app/shared/home_cubit/social_states.dart';
import 'package:social_app/shared/styles/color.dart';
import 'package:social_app/widgets/default_button.dart';
import 'package:social_app/widgets/default_textformfield.dart';

class EditProfile extends StatelessWidget {
  // const EditProfile({Key? key}) : super(key: key);
  static const screenRoute = '/EditProfile';
  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is GetDataSuccessfullyState) {
          showToast(msg: 'Updated successfully');
        }
        if (state is GetDataErrorState) {
          showToast(msg: 'Unfortunately an error occurred');
        }
        if(state is UploadCoverImageSuccessState )
        {

          SocialCubit.get(context).coverImage = null ;
          print('cover image is ${SocialCubit.get(context).coverImage }');
        }
        if(state is UploadProfileImageSuccessState )
        {

          SocialCubit.get(context).profileImage = null ;
          print('profile image is ${SocialCubit.get(context).profileImage }');
        }
      },
      builder: (context, state) {

        var userModel = SocialCubit.get(context).userModelData;
        var coverImage = SocialCubit.get(context).coverImage;
        var profileImage = SocialCubit.get(context).profileImage;

        // ImageProvider? profileImage;
        // if (profileFile == null) {
        //   profileImage = NetworkImage(userModel!.image!);
        // } else {
        //   profileImage = FileImage(profileFile);
        // }

        usernameController.text = userModel!.username!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: defaultAppBar(
            context,
            title: 'Edit Profile',
            onLeadingPressed: (){
              Navigator.pop(context);
            },
            actions: [
              TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUserInformation(
                      username: usernameController.text,
                      bio: bioController.text,
                      phone: phoneController.text);
                  // SocialCubit.get(context).uploadProfileImage();
                  FocusScope.of(context).unfocus();
                },
                child: const Text('UPDATE'),
              ),
              const SizedBox(width: 15),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateProfileInformationLoadingState)
                    const LinearProgressIndicator(),
                  if (state is UpdateProfileInformationLoadingState)
                    const SizedBox(height: 5),
                  if (state is UpdateProfileInformationLoadingState)
                    const SizedBox(height: 10),
                  SizedBox(
                    height: 220.0,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 170,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Image(
                                  image: coverImage == null
                                      ? NetworkImage(userModel!.cover!)
                                      : FileImage(coverImage)
                                  as ImageProvider,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 170,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 10),
                                child: defaultCircleAvatar(
                                  onPressed: () {
                                    SocialCubit.get(context)
                                        .picCoverImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: 63,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage(userModel!.image!)
                                      : FileImage(profileImage)
                                  as ImageProvider,
                                ),
                              ),
                              defaultCircleAvatar(
                                onPressed: () {
                                  SocialCubit.get(context)
                                      .picProfileImage();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null )
                    const SizedBox(height: 25),
                  if (SocialCubit.get(context).profileImage != null ||
                      SocialCubit.get(context).coverImage != null )
                    Row(
                      children: [
                        if (SocialCubit.get(context).profileImage != null )
                        // if (SocialCubit.get(context).profileImage != null && state is! GetDataSuccessfullyState && state is! UploadCoverImageSuccessState)
                          Expanded(
                            child: Column(
                              children: [
                                DefaultButton(
                                  height: 45,
                                  fontSize: 14,
                                  text: 'Update Profile ',
                                  onTap: () {
                                    SocialCubit.get(context)
                                        .uploadProfileImage(
                                      username: usernameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                if (state is UploadProfileImageLoadingState ||
                                    state is UploadCoverImageLoadingState)
                                  const SizedBox(height: 15),
                                if (state is UploadProfileImageLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                        if (SocialCubit.get(context).coverImage != null)
                          const SizedBox(width: 8),
                        if (SocialCubit.get(context).coverImage != null)
                        // if (SocialCubit.get(context).coverImage != null && state is! UploadCoverImageSuccessState && state is! UploadProfileImageSuccessState)
                          Expanded(
                            child: Column(
                              children: [
                                DefaultButton(
                                  fontSize: 14,
                                  height: 45,
                                  text: 'Update Cover ',
                                  onTap: () {
                                    SocialCubit.get(context)
                                        .uploadCoverImage(
                                      username: usernameController.text,
                                      bio: bioController.text,
                                      phone: phoneController.text,
                                    );
                                    FocusScope.of(context).unfocus();
                                  },
                                ),
                                if (state
                                is UploadProfileImageLoadingState ||
                                    state is UploadCoverImageLoadingState)
                                  const SizedBox(height: 15),
                                if (state is UploadCoverImageLoadingState)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 35),
                  DefaultTextFormField(
                    prefixIcon: Icons.person,
                    controller: usernameController,
                    keyboardType: TextInputType.text,
                    hintText: 'Username',
                    validator: (inputValue) {
                      if (inputValue!.isEmpty) {
                        return 'Username required';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      SocialCubit.get(context).updateUserInformation(
                          username: usernameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  DefaultTextFormField(
                    prefixIcon: Icons.info_outline,
                    controller: bioController,
                    keyboardType: TextInputType.text,
                    hintText: 'Bio',
                    validator: (inputValue) {
                      if (inputValue!.isEmpty) {
                        return 'Username required';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      SocialCubit.get(context).updateUserInformation(
                          username: usernameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  DefaultTextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    hintText: 'Phone',
                    validator: (inputValue) {
                      if (inputValue!.isEmpty) {
                        return 'Phone required';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (_) {
                      SocialCubit.get(context).updateUserInformation(
                          username: usernameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  defaultCircleAvatar({required Function() onPressed}) => CircleAvatar(
      radius: 18,
      backgroundColor: AppColor.mainColor,
      child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.camera_alt_outlined,
            size: 16,
            color: Colors.white,
          )));
}
