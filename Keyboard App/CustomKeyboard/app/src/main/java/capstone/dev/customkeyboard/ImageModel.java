package capstone.dev.customkeyboard;

public class ImageModel {

    public String imageName;
    public String imageURL;


    public ImageModel() {

    }

    public ImageModel(String name, String url) {
        this.imageName = name;
        this.imageURL = url;
    }


    public String getName() {
        return imageName;
    }


    public String getUrl() {
        return imageURL;
    }

}
